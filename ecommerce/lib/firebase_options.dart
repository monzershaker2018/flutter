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
    apiKey: 'AIzaSyCyvAWA0fRlR4x5vYEWSHMgzv14K-8wEjI',
    appId: '1:878496232655:web:dbaf025d4f5cbfec4973ba',
    messagingSenderId: '878496232655',
    projectId: 'ecommerce-62027',
    authDomain: 'ecommerce-62027.firebaseapp.com',
    storageBucket: 'ecommerce-62027.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWZ4j7shy6FVjoHDG-GBQgDGaAIYrdQhE',
    appId: '1:878496232655:android:4c9e0084911943934973ba',
    messagingSenderId: '878496232655',
    projectId: 'ecommerce-62027',
    storageBucket: 'ecommerce-62027.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB--cw4p3WQzP4y1wIFlLjbUhE5mChjeaM',
    appId: '1:878496232655:ios:5f6f9de92e38fab64973ba',
    messagingSenderId: '878496232655',
    projectId: 'ecommerce-62027',
    storageBucket: 'ecommerce-62027.appspot.com',
    iosClientId: '878496232655-jg1ni3edo5ea719qbnvi2mlngh5ps69g.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerce',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB--cw4p3WQzP4y1wIFlLjbUhE5mChjeaM',
    appId: '1:878496232655:ios:5f6f9de92e38fab64973ba',
    messagingSenderId: '878496232655',
    projectId: 'ecommerce-62027',
    storageBucket: 'ecommerce-62027.appspot.com',
    iosClientId: '878496232655-jg1ni3edo5ea719qbnvi2mlngh5ps69g.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerce',
  );
}
