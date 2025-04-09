import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/responsive_login_wrapper.dart'; // Import the responsive wrapper
import 'config/firebaseconfig.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/main.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initializeFirebase();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => UserPinProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Games',
      debugShowCheckedModeBanner: false, // Disables the debug banners
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF6C63FF),
          primary: Color(0xFF6C63FF),
        ),
      ),
       home: LoginScreen(),
      // Use ResponsiveLoginWrapper as the home screen instead of LoginScreen
      // home: const ResponsiveLoginWrapper(),
    );
  }
}

