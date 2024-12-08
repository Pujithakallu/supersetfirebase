import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseConfig {
  static final FirebaseOptions webOptions = FirebaseOptions(
    apiKey: "AIzaSyDYC7_yReYQZJWTl1O9n3auL9pRCZQp4A4",
    authDomain: "fih-superset-dev.firebaseapp.com",
    projectId: "fih-superset-dev",
    storageBucket: "fih-superset-dev.firebasestorage.app",
    messagingSenderId: "1058242616848",
    appId: "1:1058242616848:web:7f407ce57f5ae4eafb3495",
    measurementId: "G-1MLYB5F9ZG"
  );

  static Future<void> initializeFirebase() async {
    if (kIsWeb) {
      // Web initialization
      await Firebase.initializeApp(options: webOptions);
    } else {
      // Android initialization
      await Firebase.initializeApp();
    }
  }
}