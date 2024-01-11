// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCwRkM21MbxsUuvCtQ3Y0UapqGfkwG-tpM',
    appId: '1:210663146928:web:dee82bef7764024c274275',
    messagingSenderId: '210663146928',
    projectId: 'hello-fdb7a',
    authDomain: 'hello-fdb7a.firebaseapp.com',
    databaseURL: 'https://hello-fdb7a.firebaseio.com',
    storageBucket: 'hello-fdb7a.appspot.com',
    measurementId: 'G-X04EVHBLBV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxQ1G-UKN8-QcOGvLTKzrtrw1aklzhoxo',
    appId: '1:210663146928:android:ade47caf086b3116274275',
    messagingSenderId: '210663146928',
    projectId: 'hello-fdb7a',
    databaseURL: 'https://hello-fdb7a.firebaseio.com',
    storageBucket: 'hello-fdb7a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUVH7IYeG39O1QrvmSJWPqV961DkZtQyg',
    appId: '1:210663146928:ios:f2c227efb19f66bd274275',
    messagingSenderId: '210663146928',
    projectId: 'hello-fdb7a',
    databaseURL: 'https://hello-fdb7a.firebaseio.com',
    storageBucket: 'hello-fdb7a.appspot.com',
    androidClientId: '210663146928-f48qnnqasajgcpaddntolcppo8baldfd.apps.googleusercontent.com',
    iosClientId: '210663146928-85tebmn7r8ed16pc29uoa4r58qismb5u.apps.googleusercontent.com',
    iosBundleId: 'com.example.collarlink',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUVH7IYeG39O1QrvmSJWPqV961DkZtQyg',
    appId: '1:210663146928:ios:a08846189dd73a9c274275',
    messagingSenderId: '210663146928',
    projectId: 'hello-fdb7a',
    databaseURL: 'https://hello-fdb7a.firebaseio.com',
    storageBucket: 'hello-fdb7a.appspot.com',
    androidClientId: '210663146928-f48qnnqasajgcpaddntolcppo8baldfd.apps.googleusercontent.com',
    iosClientId: '210663146928-eq0lgaujkg5h5ijfruvq61k8rmhkss79.apps.googleusercontent.com',
    iosBundleId: 'com.example.collarlink.RunnerTests',
  );
}
