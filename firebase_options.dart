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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'demo-api-key-web',
    appId: '1:123456789:web:demo',
    messagingSenderId: '123456789',
    projectId: 'pulse-path-demo',
    authDomain: 'pulse-path-demo.firebaseapp.com',
    storageBucket: 'pulse-path-demo.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-api-key-android',
    appId: '1:123456789:android:demo',
    messagingSenderId: '123456789',
    projectId: 'pulse-path-demo',
    storageBucket: 'pulse-path-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'demo-api-key-ios',
    appId: '1:123456789:ios:demo',
    messagingSenderId: '123456789',
    projectId: 'pulse-path-demo',
    storageBucket: 'pulse-path-demo.appspot.com',
    iosBundleId: 'com.example.pulsePath',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'demo-api-key-macos',
    appId: '1:123456789:ios:demo',
    messagingSenderId: '123456789',
    projectId: 'pulse-path-demo',
    storageBucket: 'pulse-path-demo.appspot.com',
    iosBundleId: 'com.example.pulsePath',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'demo-api-key-windows',
    appId: '1:123456789:web:demo',
    messagingSenderId: '123456789',
    projectId: 'pulse-path-demo',
    authDomain: 'pulse-path-demo.firebaseapp.com',
    storageBucket: 'pulse-path-demo.appspot.com',
  );
}