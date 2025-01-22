import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'menu.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure Firebase is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(MaterialApp(
    home: const WelcomeScreen(),
    routes: {
      '/welcomescreen': (context) => const WelcomeScreen(),
      '/menu': (context) => Menu(),
      '/home': (context) => MyHomePage(),
      '/studymaterial': (context) => StudyMaterialScreen(),
      '/matching': (context) => MatchGame(),
      '/memory': (context) => MemoryGame(),
    },
  ));
}

class WelcomeScreen extends StatelessWidget {
  final String? userPin;
  
  const WelcomeScreen({
    Key? key,
    this.userPin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Mathmingle/gif1.gif'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'W E L C O M E',
                style: TextStyle(
                  fontSize: 140,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 300),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/menu');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(600, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                child: Text(
                  'LET\'S DIVE IN !!!!!!',
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}