import 'dart:developer';

import 'package:collarlink/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/post_screen.dart';
import 'screens/home.dart';
import 'screens/task_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: const LoginScreen(),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/DisplayPost': (context) => PostScreen(),
        '/task': (context) => TasksScreen(),
        '/createTask': (context) => CreateTask(),
      },
    );
  }
}

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Delay for 3 seconds before navigating to the main app screen
//     Future.delayed(Duration(seconds: 3), () {
//       Navigator.pushReplacementNamed(context, '/home');
//     });

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/google.png'),
//             // fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));

      if (AuthService.currentUser != null) {
        log('\nUser: ${AuthService.currentUser}');
        //navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text(
                AuthService.prefs.getBool('isLoggedIn')?.toString() ?? 'false'),
            Text("fgvd"),
            Text("fgvd"),
            Text("fgvd"),
            Text("fgvd"),
          ],
        ),
      ),
    );
  }
}
