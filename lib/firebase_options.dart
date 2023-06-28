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
    apiKey: 'AIzaSyC6uqeVaTNQqL9Cm6QGRG70JEhrMgR47RQ',
    appId: '1:970302257756:web:2e013e8ede060f8f194499',
    messagingSenderId: '970302257756',
    projectId: 'barcode-ta',
    authDomain: 'barcode-ta.firebaseapp.com',
    storageBucket: 'barcode-ta.appspot.com',
    measurementId: 'G-XKP1JNWBYB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8deX0VGEIhm-JO3Kdl3hoO-WeqeO4dyM',
    appId: '1:970302257756:android:dc4d4ff10f187d7e194499',
    messagingSenderId: '970302257756',
    projectId: 'barcode-ta',
    storageBucket: 'barcode-ta.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJ4RxKDo7ZLf45MzMmH58_SWsj-TGYalc',
    appId: '1:970302257756:ios:71dddd9d0fb79d15194499',
    messagingSenderId: '970302257756',
    projectId: 'barcode-ta',
    storageBucket: 'barcode-ta.appspot.com',
    iosClientId: '970302257756-1jcbj9f8kqkqbijiu05h735hf53ehght.apps.googleusercontent.com',
    iosBundleId: 'com.example.barcodeTa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJ4RxKDo7ZLf45MzMmH58_SWsj-TGYalc',
    appId: '1:970302257756:ios:71dddd9d0fb79d15194499',
    messagingSenderId: '970302257756',
    projectId: 'barcode-ta',
    storageBucket: 'barcode-ta.appspot.com',
    iosClientId: '970302257756-1jcbj9f8kqkqbijiu05h735hf53ehght.apps.googleusercontent.com',
    iosBundleId: 'com.example.barcodeTa',
  );
}