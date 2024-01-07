import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:collarlink/models/chat_user.dart';

//   signInWithGoogle() async {
//     //begin interactive sign in progress
//     static GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     //obtain auth details from request
//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;
// //create a new credential for user
//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );
//     //finally use let sign in
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   //use function to signout from current googleaccount
//   Future<void> signOut(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       // Handle any additional sign out operations, such as navigating to a new screen.
//     } catch (e) {
//       print('Failed to sign out: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to sign out'),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
class AuthService {
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static FirebaseAuth _auth = FirebaseAuth.instance;
  // static FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static FirebaseFirestore store = FirebaseFirestore.instance;

  static ChatUser me = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey, I'm using We Chat!",
      image: user.photoURL.toString(),
      createdAt: '',
      isOnline: false,
      lastActive: '',
      pushToken: '');

  static User get user => _auth.currentUser!;

  static Future<User?> handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // User canceled the sign-in process
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (error) {
      print('Error signing in: $error');
      return null;
    }
  }

  static Future<void> handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (error) {
      print('Error signing out: $error');
    }
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  //If current user don't have a data in firestore then create a dumby data for current user
  static Future<void> createNewUser() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      // Check if the user document already exists
      DocumentSnapshot userSnapshot =
          await store.collection('users').doc(currentUser.uid).get();

      if (!userSnapshot.exists) {
        // Create a map with the user data
        Map<String, dynamic> userData = {
          'name': 'John Doe',
          'about': 'Hello, I am a new user',
          'email': currentUser.email,
          'userId': currentUser.uid,
        };

        // Store the user data in the 'users' collection in Firestore
        await store.collection('users').doc(currentUser.uid).set(userData);
      }
    }
  }
}

Future<void> handleBackground(RemoteMessage message) async {
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data);
}

class FirebaseApi {
  static Future<void> initNotification() async {
    final _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print(token);

    FirebaseMessaging.onMessage.listen((message) {
      print(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackground);
  }
}
