import 'dart:ffi';
import 'dart:ui';

import 'package:collarlink/api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter/services.dart";
import "home.dart";
import 'dart:developer';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});
  TextEditingController phonenumbercontroller = TextEditingController();

  // Shared Preferences

  // @override
  // void initState(context) {
  //   Future.delayed(const Duration(seconds: 2), () {
  //     //exit full-screen
  //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //         systemNavigationBarColor: Colors.white,
  //         statusBarColor: Colors.white));

  //     if (AuthService.currentUser != null) {
  //       log('\nUser: ${AuthService.currentUser}');
  //       //navigate to home screen
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (_) => HomeScreen()));
  //     } else {
  //       //navigate to login screen
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (_) => LoginScreen()));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // log("nothing");

    // AuthService.initializePreferences();
    // AuthService.savePreference('role', 'worker');

    // AuthService.getPreference("role").then((value) {
    //   log(value);
    //   log("here");
    //   // log():
    // });
    // initState(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 201, 182, 204),
                Color.fromARGB(255, 161, 128, 196),
              ],
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
            // elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 100, top: 100),
                    child: SizedBox(
                      child: Image.asset('assets/images/img_telegram_cloud.png',
                          height: 230),
                    ),
                  ),
                  // TextField(
                  //   controller: phonenumbercontroller,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Phone Number',
                  //   ),
                  // ),
                  // Row(
                  //   children: [
                  //     TextButton(
                  //         onPressed: () {
                  //           AuthService.signInWithPhoneNumber(
                  //               phonenumbercontroller.text);
                  //         },
                  //         child: Text("login"))
                  //   ],
                  // ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: MaterialButton(
                      color: Colors.grey[300],
                      elevation: 10,
                      onPressed: () async {
                        await AuthService.stasignInWithGoogle();

                        AuthService.savePreference('email', 'worker');

                        // Navigator.pushReplacementNamed(context, '/choose');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ChoosePerson()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/google.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Text("Sign In with Google  "),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "or ",
                    style: TextStyle(fontSize: 20),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      color: Colors.grey[200],
                      elevation: 10,
                      onPressed: () async {
                        await AuthService.stasignInWithGoogle();

                        AuthService.savePreference('email', 'worker');

                        // Navigator.pushReplacementNamed(context, '/choose');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ChoosePerson()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Image.asset(
                          //   "assets/images/google.png",
                          //   width: 30,
                          // ),
                          Icon(
                            Icons.call,
                            size: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Text("Sign In with number "),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//login screen
class ChoosePerson extends StatelessWidget {
  const ChoosePerson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          child: Row(
            children: [
              Icon(Icons.person),
              Text('I am a Worker'),
            ],
          ),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, '/task');
            // AuthService.prefs?.setString('role', 'worker');
          },
        ),
        SizedBox(
          width: 16,
        ),
        TextButton(
          child: Row(
            children: [
              Icon(Icons.work),
              Text('I am a Contractor'),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
            AuthService.savePreference('email', 'contractor');
          },
        ),
      ],
    )));
  }
}

//TODO:
//test the login
