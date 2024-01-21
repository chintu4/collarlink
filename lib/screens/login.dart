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
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
          child: Card(
            margin: EdgeInsets.all(30),
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Image.asset('assets/images/img_telegram_cloud.png'),
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
                  MaterialButton(
                    color: Colors.teal[100],
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
                            width: 30.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text("Sign In with Google"),
                      ],
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
  const ChoosePerson({Key ?key,});

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
