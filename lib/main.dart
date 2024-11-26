
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the correct Firebase Database URL
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  FirebaseDatabase.instance.databaseURL = "https://supersetfirebase-1decb-default-rtdb.firebaseio.com/";

  runApp(SupersetFirebaseApp());
}

class SupersetFirebaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superset Firebase',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
