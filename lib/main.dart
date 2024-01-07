import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'api/api.dart';
import 'screens/googleSign.dart';
import 'screens/page1.dart';
import 'screens/splash_screen.dart';

//global object for accessing device screen size
late Size mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseMessaging.instance.getToken();
  // await FirebaseApi.initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Future<void> deviceToken() async {
  //   final FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   print('User granted permission: ${settings.authorizationStatus}');
  // }

  @override
  Widget build(BuildContext context) {
//     NotificationSettings settings = await messaging.requestPermission(
//   alert: true,
//   announcement: false,
//   badge: true,
//   carPlay: false,
//   criticalAlert: false,
//   provisional: false,
//   sound: true,
// );

// print('User granted permission: ${settings.authorizationStatus}');

    return MaterialApp(
      title: 'Flutter Firebase Messaging Demo',
      home: SplashScreen(),
    );
  }
}

  // void initFirebaseMessaging() {
  //   _firebaseMessaging.requestPermission();
  //   _firebaseMessaging.getToken().then((token) {
  //     print('Firebase Messaging Token: $token');
  //   });

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print(
  //         'Received a message in the foreground: ${message.notification?.body}');
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('User tapped on a notification: ${message.notification?.body}');
  //   });
  // }
// }
// }


