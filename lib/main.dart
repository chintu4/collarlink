// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:message/screens/login.dart';
import 'package:message/screens/home.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  // Remove duplicate declaration of isLoggedIn
  // bool? isLoggedIn = true;
  try {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  } catch (e, st) {
    print(e);
    print(st);
  }

  await Firebase.initializeApp();

  runApp(MyApp()); //isLoggedIn: isLoggedIn ?? false));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}


// class MyApp extends StatelessWidget {
//   final bool isLoggedIn;
//   MyApp({required this.isLoggedIn});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       home: isLoggedIn ? HomeScreen() : LoginScreen(),
//       routes: {
//         // Define routes for navigation
//         '/login': (context) => LoginScreen(),
//         '/home': (context) => HomeScreen(),
//       },
//     );
//   }
// }
