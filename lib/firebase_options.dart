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
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBjC4PEX3O3PP96VgNdbz83XXWJUu3QY5E',
    appId: '1:627202204044:web:4a1c58b15f0c9b7f0f0f0f',
    messagingSenderId: '627202204044',
    projectId: 'realtimeexpensetracker-3feeb',
    authDomain: 'realtimeexpensetracker-3feeb.firebaseapp.com',
    storageBucket: 'realtimeexpensetracker-3feeb.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjC4PEX3O3PP96VgNdbz83XXWJUu3QY5E',
    appId: '1:627202204044:android:4a1c58b15f0c9b7f0f0f0f',
    messagingSenderId: '627202204044',
    projectId: 'realtimeexpensetracker-3feeb',
    storageBucket: 'realtimeexpensetracker-3feeb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjC4PEX3O3PP96VgNdbz83XXWJUu3QY5E',
    appId: '1:627202204044:ios:4a1c58b15f0c9b7f0f0f0f',
    messagingSenderId: '627202204044',
    projectId: 'realtimeexpensetracker-3feeb',
    storageBucket: 'realtimeexpensetracker-3feeb.appspot.com',
    iosClientId: 'unused',
    iosBundleId: 'com.example.realTimeExpenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjC4PEX3O3PP96VgNdbz83XXWJUu3QY5E',
    appId: '1:627202204044:ios:4a1c58b15f0c9b7f0f0f0f',
    messagingSenderId: '627202204044',
    projectId: 'realtimeexpensetracker-3feeb',
    storageBucket: 'realtimeexpensetracker-3feeb.appspot.com',
    iosClientId: 'unused',
    iosBundleId: 'com.example.realTimeExpenseTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBjC4PEX3O3PP96VgNdbz83XXWJUu3QY5E',
    appId: '1:627202204044:web:4a1c58b15f0c9b7f0f0f0f',
    messagingSenderId: '627202204044',
    projectId: 'realtimeexpensetracker-3feeb',
    authDomain: 'realtimeexpensetracker-3feeb.firebaseapp.com',
    storageBucket: 'realtimeexpensetracker-3feeb.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyBjC4PEX3O3PP96VgNdbz83XXWJUu3QY5E',
    appId: '1:627202204044:web:4a1c58b15f0c9b7f0f0f0f',
    messagingSenderId: '627202204044',
    projectId: 'realtimeexpensetracker-3feeb',
    authDomain: 'realtimeexpensetracker-3feeb.firebaseapp.com',
    storageBucket: 'realtimeexpensetracker-3feeb.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );
}
