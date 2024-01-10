import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static SharedPreferences? prefs;
  static bool isLoggedIn = false;

  static Future<void> setSharedPref(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(key, value);
  }

  static Future<String> getSharedPref(String key) async {
    prefs = await SharedPreferences.getInstance();

    return prefs!.getString(key)!;
  }

  // static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //google SignIn
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static User? get currentUser => _auth.currentUser;

  // static GoogleSignInAccount? _googleAuth = GoogleSignIn();

  static Future<UserCredential> stasignInWithGoogle() async {
    //begin interactive sign in progress
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally use let sign in
    return await _auth.signInWithCredential(credential);
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  static Future<bool> isAuthenticated() async {
    try {
      // Check for existing authentication state using Firebase
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // User is signed in
        return true;
      } else {
        // User is not signed in
        return false;
      }
    } catch (e) {
      // Handle any errors during authentication check
      print("Error checking authentication: $e");
      return false;
    }
  }
}

// class AuthSign {
//   static signInWithGoogle() async {
//     //begin interactive sign in progress
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

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
// }

// class AuthService2 {

//   static GoogleSignIn _googleSignIn = GoogleSignIn();

//   static Future<void> handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print('Error signing in: $error');
//     }
//   }

//   static Future<void> handleSignOut() async {
//     try {
//       await _googleSignIn.signOut();
//     } catch (error) {
//       print('Error signing out: $error');
//     }
//   }
// }
