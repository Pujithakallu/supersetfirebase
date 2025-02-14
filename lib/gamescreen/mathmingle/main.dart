import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'homescreen.dart';
import 'menu.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';
import '../../utils/util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MathMingleApp(userPin: ''));
}

// main.dart
class MathMingleApp extends StatelessWidget {
  final String userPin;
  const MathMingleApp({required this.userPin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  WelcomeScreen(userPin: userPin,),
        '/menu': (context) => const Menu(),
        '/studymaterial': (context) => const StudyMaterialScreen(),
        '/matching': (context) => const MatchGame(),
        '/memory': (context) => const MemoryGame(),
      },
     onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case '/home':
          final chapterArg = settings.arguments as int? ?? 1; // Ensure it's an int, default to 1
          return MaterialPageRoute(
            builder: (context) => MyHomePage(chapterNumber: chapterArg),
          );
        default:
          return MaterialPageRoute(
            builder: (context) =>  WelcomeScreen(userPin: userPin),
          );
    }
}


    );
  }
}
// WelcomeScreen remains unchanged
class WelcomeScreen extends StatelessWidget {
  final String userPin;

   WelcomeScreen({ required this.userPin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
            'Hi, $userPin!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A4A4A),
            ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: Color(0xFF6C63FF),
              size: 26,
            ),
            onPressed: () => logout(context),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Mathmingle/gif1.gif'),
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
              const Text(
                'W E L C O M E',
                style: TextStyle(
                  fontSize: 140,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 300),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const Menu(),
                      transitionsBuilder: (context, animation1, animation2, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation1.drive(tween);
                        return SlideTransition(position: offsetAnimation, child: child);
                      },
                      fullscreenDialog: true,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(600, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                child: const Text(
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