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
    apiKey: 'AIzaSyDV7i0ODYNSRXiQ1TNtbFCswWt2Bk2jU6Q',
    appId: '1:894469207553:web:7b5de72ad2100187fff200',
    messagingSenderId: '894469207553',
    projectId: 'bike-events-b1fe3',
    authDomain: 'bike-events-b1fe3.firebaseapp.com',
    storageBucket: 'bike-events-b1fe3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDf9lAETLZYlldQmOvI9uDSU4fPs4c_3jc',
    appId: '1:894469207553:android:0301de767ef1626dfff200',
    messagingSenderId: '894469207553',
    projectId: 'bike-events-b1fe3',
    storageBucket: 'bike-events-b1fe3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZCSJvIPinSxIXvAt72qUxE3AMVZPntjo',
    appId: '1:894469207553:ios:239fe2e68bebf8e7fff200',
    messagingSenderId: '894469207553',
    projectId: 'bike-events-b1fe3',
    storageBucket: 'bike-events-b1fe3.appspot.com',
    iosClientId:
        '894469207553-cv0vh37niaijblsgibeg5f3b8r72qmgq.apps.googleusercontent.com',
    iosBundleId: 'com.example.bikeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZCSJvIPinSxIXvAt72qUxE3AMVZPntjo',
    appId: '1:894469207553:ios:239fe2e68bebf8e7fff200',
    messagingSenderId: '894469207553',
    projectId: 'bike-events-b1fe3',
    storageBucket: 'bike-events-b1fe3.appspot.com',
    iosClientId:
        '894469207553-cv0vh37niaijblsgibeg5f3b8r72qmgq.apps.googleusercontent.com',
    iosBundleId: 'com.example.bikeApp',
  );
}