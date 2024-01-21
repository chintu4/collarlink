import 'dart:developer';

import 'package:collarlink/Internet/controller.dart';
import 'package:collarlink/screens/chat_screen.dart';
import 'package:collarlink/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/post_screen.dart';
import 'screens/home.dart';
// import 'dart:io' if (dart.library.js) 'dart:js';
import 'screens/task_screen.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart'; //splash screen.dart
// import 'package:shared_preferences/shared_preferences.dart'; //shared_preferences.dart
import 'api/api.dart';
import 'screens/profile_screen.dart';
import 'screens/sideBar.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:collarlink/screens/contract.dart';
import 'package:collarlink/screens/home_screen.dart';
// import 'package:collarlink/main.dart';

late Size mq = Size.zero;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // AuthService.initializePreferences();
  DependencyInjection.init();

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var email = prefs.getString('email');
  // log(email.toString());

  runApp(MyApp());

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // AuthService.prefs?.setString('role', 'worker');

  @override
  Widget build(BuildContext context) {
    dynamic email = null;
    AuthService.getPreference("role").then((value) {
      email = value;
    });
    // AuthService.savePreference('role', 'worker');
    // log(AuthService.getPreference('isLoggedin').toString());

    return GetMaterialApp(
      title: 'Flutter Demo',
      // home: const LoginScreen(),
      // initialRoute: (email != null) ? '/home' : '/login', //'/home')/login',
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,

      routes: {
        '/splash': (context) => SplashScreen(), // to create a splash scren
        '/login': (context) => LoginScreen(), // to create a login screen
        '/home': (context) => HomeScreen(),

        /// to display the home screen
        '/createTask': (context) => PostScreen(), // to display the post
        '/task': (context) => TasksScreen(), // to create a task
        // '/DisplayPost': (context) => CreateTask(), // to create a task
        '/profile': (context) => ProfileScreen(), //to post screen
        '/choose': (context) => ChoosePerson(),
        '/recentPost': (context) => RecentPost(),
        '/contract': (context) => ContractScreen(typeOfPerson: "contractor"),
        //opens when sliderpage is clicked
        '/history': (context) => TaskHistoryScreen(),
        '/chatScreen': (context) => ChatScreen(user: AuthService.me),
        '/chatHomeScreen': (context) => ChatHomeScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

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
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // Text(AuthService.prefs?.getString('user') ?? "fgvd"),
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

class MyDropdownList extends StatefulWidget {
  @override
  _MyDropdownListState createState() => _MyDropdownListState();
}

class _MyDropdownListState extends State<MyDropdownList> {
  String selectedValue = ''; // Variable to store the selected value

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Selected Value: $selectedValue',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        DropdownButton<String>(
          value: selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
