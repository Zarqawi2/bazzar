import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:477346909142:ios:49d3e01f0c269c63067277',
        apiKey: 'AIzaSyAPKZEQEguV80vRCxvrV3KtpsOda0sYvbc',
        projectId: 'bazzar-app-e40c5',
        messagingSenderId: '477346909142',
        iosBundleId: 'com.example.bazzarApp',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:477346909142:android:3ffa31510b90a0f1067277',
        apiKey: 'AIzaSyD9z6JPhe_hOx-hR1rwEGdfFq9_Kkh3n0g',
        projectId: 'bazzar-app-e40c5',
        messagingSenderId: '477346909142',
      );
    }
  }
}
