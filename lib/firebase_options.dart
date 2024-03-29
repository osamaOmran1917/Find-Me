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
    apiKey: 'AIzaSyBQ37j1bwo7J9EQ8K3BfL9NrHkBKmOkYeA',
    appId: '1:49444864484:web:140e9aa857b38c30ef87f1',
    messagingSenderId: '49444864484',
    projectId: 'find-me-dce6d',
    authDomain: 'find-me-dce6d.firebaseapp.com',
    storageBucket: 'find-me-dce6d.appspot.com',
    measurementId: 'G-YK0QM68C2T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBucLj8uQ2e2HFY1QMVcs5oJLCS0bXLf5I',
    appId: '1:49444864484:android:70a78f10ac7ebfe4ef87f1',
    messagingSenderId: '49444864484',
    projectId: 'find-me-dce6d',
    storageBucket: 'find-me-dce6d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOGZbEt6D7cJhR2JNFJ4hcCyqm9QR9WQw',
    appId: '1:49444864484:ios:c644e5d6966b5304ef87f1',
    messagingSenderId: '49444864484',
    projectId: 'find-me-dce6d',
    storageBucket: 'find-me-dce6d.appspot.com',
    androidClientId: '49444864484-ebdf3dqjv4ilbbnhuj7lmlajmpnkpoi2.apps.googleusercontent.com',
    iosClientId: '49444864484-kq1qnacttcfkmajc7euvgfvdhl33169f.apps.googleusercontent.com',
    iosBundleId: 'com.example.findMeIi',
  );
}
