//SignInScreen

// import 'dart:html';
import 'package:collarlink/api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:/homepage.dart';

// class SignInScreen extends StatefulWidget {
//   SignInScreen({Key key = const Key('default')}) : super(key: key);

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.blue,
//               Colors.red,
//             ],
//           ),
//         ),
//         child: Card(
//           margin: EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
//           elevation: 20,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 "GEEKS FOR GEEKS",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: MaterialButton(
//                   color: Colors.teal[100],
//                   elevation: 10,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 30.0,
//                         width: 30.0,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/googleimage.png'),
//                             fit: BoxFit.cover,
//                           ),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Text("Sign In with Google"),
//                     ],
//                   ),
//                   onPressed: () {
//                     signup(context);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // function to implement the google signin

// // creating firebase instance
// final FirebaseAuth auth = FirebaseAuth.instance;

// Future<void> signup(BuildContext context) async {
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   final GoogleSignInAccount googleSignInAccount =
//       await googleSignIn.signIn() as GoogleSignInAccount;

//   if (googleSignInAccount != null) {
//     final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;
//     final AuthCredential authCredential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken);

//     // Getting users credential
//     UserCredential result = await auth.signInWithCredential(authCredential);
//     User user = result.user!;

//     if (result != null) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => HomePage()));
//     } // if result not null we simply call the MaterialpageRoute,
//     // for go to the HomePage screen
//   }
// }

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.red,
            ],
          ),
        ),
        child: Card(
          margin: EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "GEEKS FOR GEEKS",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  color: Colors.teal[100],
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   image: AssetImage('assets/images/googleimage.png'),
                          //   fit: BoxFit.cover,
                          // ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          print("button pressed00");
                          AuthSign.signInWithGoogle();
                        },
                        child: Text("Sign In with Google"),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // signup(context);
                    SnackBar(
                      content: Text('your have a tap'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthSign {
  static signInWithGoogle() async {
    //begin interactive sign in progress
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
//create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally use let sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
