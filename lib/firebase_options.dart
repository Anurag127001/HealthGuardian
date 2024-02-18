
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyA4BEzA7_slWJv81KQ_ayO2CnutsOh_uMU',
    appId: '1:472305237336:web:e4df7abe0b245849d9792d',
    messagingSenderId: '472305237336',
    projectId: 'health360-5ba1a',
    authDomain: 'health360-5ba1a.firebaseapp.com',
    storageBucket: 'health360-5ba1a.appspot.com',
    measurementId: 'G-9R97S8EZ75',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXOVcE8-POU-1D1bCr1AjtFdD1HUJEP84',
    appId: '1:472305237336:android:57b049f20d3bafc6d9792d',
    messagingSenderId: '472305237336',
    projectId: 'health360-5ba1a',
    storageBucket: 'health360-5ba1a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClw_vqo38saUusqbL0jfo9sbuWHeXYmzc',
    appId: '1:472305237336:ios:227344a47273b289d9792d',
    messagingSenderId: '472305237336',
    projectId: 'health360-5ba1a',
    storageBucket: 'health360-5ba1a.appspot.com',
    iosBundleId: 'com.example.sampleandro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClw_vqo38saUusqbL0jfo9sbuWHeXYmzc',
    appId: '1:472305237336:ios:29d449f937e98e6bd9792d',
    messagingSenderId: '472305237336',
    projectId: 'health360-5ba1a',
    storageBucket: 'health360-5ba1a.appspot.com',
    iosBundleId: 'com.example.sampleandro.RunnerTests',
  );
}
