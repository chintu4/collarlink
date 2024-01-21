import 'dart:ffi';
import 'dart:ui';

import 'package:collarlink/api/api.dart';
import 'package:collarlink/main.dart';
import 'package:collarlink/screens/workerScreen.dart';
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
  void checkUserAndCreate() async {
    var snapshot = await AuthService.firestore
        .collection('users')
        .doc(AuthService.currentUser?.uid)
        .get();
    if (snapshot.exists) {
      var name = snapshot.data()?["name"];
      if (name == null) {
        await AuthService.createUser();
      }
    }
  }

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
                        // await AuthService.stasignInWithGoogle();
                        // AuthService.savePreference('email', 'worker');

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
  const ChoosePerson({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromARGB(255, 250, 225, 255),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 40,
                ),
                Text(
                  ' To Work',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            onPressed: () {
              // Navigate to SecondPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WorkersScreen()),
            );
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
                Icon(
                  Icons.work,
                  size: 36,
                ),
                Text('To Hire', style: TextStyle(fontSize: 20)),
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
              AuthService.savePreference('email', 'contractor');
            },
          ),
        ],
      )),
    ));
  }
}

//TODO:
//test the login
