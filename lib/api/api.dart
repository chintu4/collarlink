import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class AuthService {
  static SharedPreferences? _prefs; //instance

  // static Future<void> initializePreferences() async {
  //   _prefs = await SharedPreferences.getInstance();
  // }

  // static Future<void> setSharedPref(String key, String value) async {
  //   prefs = await SharedPreferences.getInstance();
  //   prefs!.setString(key, value);
  // }

  // static Future<String> getSharedPref(String key) async {
  //   prefs = await SharedPreferences.getInstance();

  //   return prefs!.getString(key)!;
  // }

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

  static Future<void> pushPostScreenData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('tasks').add(data);
    await pushRecentScreenData(data);
  }

  // static Future<void> signInWithPhoneNumber(String phoneNumber) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await _auth.signInWithCredential(credential);
  //       // Handle successful verification
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       // Handle verification failure
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       // Save the verificationId and show the code input UI
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       // Auto-retrieval timeout
  //     },
  //   );
  // }

  static Future<void> pushRecentScreenData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .collection('recentPost')
        .add(data);
  }

  static Future<void> savePreference(String key, dynamic value) async {
    _prefs?.setString(key, value);
  }

  static Future<String> getPreference(key) async {
    dynamic ret = _prefs?.get(key);
    log(ret ?? "ret is null");
    if (ret == null) {
      ret =
          "NOTHING VALUE"; // Replace `defaultValue` with the appropriate default value you want to assign.
    }
    return ret;
  }

  static Future<bool?> getAppliedStatus(String taskId) async {
    var documentSnapshot =
        await FirebaseFirestore.instance.collection('tasks').doc(taskId).get();
    var data = documentSnapshot.data();

    // Check if the document exists and contains the 'isApplied' field
    if (data != null && data.containsKey('isApplied')) {
      return data['isApplied'];
    } else {
      // Handle the case where the field is not present or the document doesn't exist
      return null;
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
