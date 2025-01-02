// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA4WLAvl0A24M6sqG8trQ0QeilyFtKjnTE',
    appId: '1:444512682343:web:e310b0a8e93252dadf6fc2',
    messagingSenderId: '444512682343',
    projectId: 'ltdd-70afa',
    authDomain: 'ltdd-70afa.firebaseapp.com',
    databaseURL: 'https://ltdd-70afa-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ltdd-70afa.firebasestorage.app',
    measurementId: 'G-C8V5EVD6LP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXbSXDNePYow3LP4tSMdMb_n0Ctllg0K4',
    appId: '1:444512682343:android:a7ba7b8e9476ebf9df6fc2',
    messagingSenderId: '444512682343',
    projectId: 'ltdd-70afa',
    databaseURL: 'https://ltdd-70afa-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ltdd-70afa.firebasestorage.app',
  );
}