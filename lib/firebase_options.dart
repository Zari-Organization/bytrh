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
    apiKey: 'AIzaSyBG99kPfi7Tq5H1ePIm0IFit0ejrzMmCNQ',
    appId: '1:897217225951:web:abae4ea44698cd130f756a',
    messagingSenderId: '897217225951',
    projectId: 'bytrhnotfication',
    authDomain: 'bytrhnotfication.firebaseapp.com',
    storageBucket: 'bytrhnotfication.appspot.com',
    measurementId: 'G-2DP36VTLLQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEMXg-Xk8uINYsfehugRfaHDGkPF2fQvk',
    appId: '1:897217225951:android:c94073dd46700e480f756a',
    messagingSenderId: '897217225951',
    projectId: 'bytrhnotfication',
    storageBucket: 'bytrhnotfication.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvxQOs6BZVYdrEJAIRUpyrwnKDrQHDj8g',
    appId: '1:897217225951:ios:4df4496c8ff605600f756a',
    messagingSenderId: '897217225951',
    projectId: 'bytrhnotfication',
    storageBucket: 'bytrhnotfication.appspot.com',
    iosClientId: '897217225951-hu8eesdpt6uupj1hqcv9vcpq6ecu1ki7.apps.googleusercontent.com',
    iosBundleId: 'com.zari.bytrh',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvxQOs6BZVYdrEJAIRUpyrwnKDrQHDj8g',
    appId: '1:897217225951:ios:4df4496c8ff605600f756a',
    messagingSenderId: '897217225951',
    projectId: 'bytrhnotfication',
    storageBucket: 'bytrhnotfication.appspot.com',
    iosClientId: '897217225951-hu8eesdpt6uupj1hqcv9vcpq6ecu1ki7.apps.googleusercontent.com',
    iosBundleId: 'com.zari.bytrh',
  );
}
