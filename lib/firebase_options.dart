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
    apiKey: 'AIzaSyBXbmYFcMXWbvBAuP1N_ionxNaZTwXAF6E',
    appId: '1:275280252691:web:9cf3e4338b91e1ce0e14e6',
    messagingSenderId: '275280252691',
    projectId: 'fb-ml-tutoria',
    authDomain: 'fb-ml-tutoria.firebaseapp.com',
    storageBucket: 'fb-ml-tutoria.appspot.com',
    measurementId: 'G-Z7K817Y3DG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUNDI2GcgiYcEsPJFNPIBUOXIh8je-uJo',
    appId: '1:275280252691:android:7458bb4d355978a50e14e6',
    messagingSenderId: '275280252691',
    projectId: 'fb-ml-tutoria',
    storageBucket: 'fb-ml-tutoria.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSLK1Rz3mx1EnEN71rKN7rlPD-vVIfFFA',
    appId: '1:275280252691:ios:c1e1cd3815ef53880e14e6',
    messagingSenderId: '275280252691',
    projectId: 'fb-ml-tutoria',
    storageBucket: 'fb-ml-tutoria.appspot.com',
    iosClientId: '275280252691-pg64ss2vo8h375vm5j5e4sv1ig2e6nu1.apps.googleusercontent.com',
    iosBundleId: 'jp.mincra.firebaseMlTutorial',
  );
}
