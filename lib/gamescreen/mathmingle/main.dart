import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'homescreen.dart';
import 'menu.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Now we simply run MathMingleApp; MultiProvider is inside MathMingleApp.
  runApp(MathMingleApp());
}

class MathMingleApp extends StatelessWidget {
  // Do not mark this widget as const
  MathMingleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp with MultiProvider here.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameData()),
        ChangeNotifierProvider(create: (_) => GameData1()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // Optionally, add a builder to MaterialApp:
        builder: (context, child) {
          return child!;
        },
        routes: {
          '/': (context) => WelcomeScreen(),
          '/menu': (context) => Menu(), // Make sure you instantiate Menu without const.
          '/studymaterial': (context) => StudyMaterialScreen(),
          '/matching': (context) => MatchGame(),
          '/memory': (context) => MemoryGame(),
        },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              final chapterArg = settings.arguments as int? ?? 1;
              return MaterialPageRoute(
                builder: (context) => MyHomePage(chapterNumber: chapterArg),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              );
          }
        },
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final String? userPin;

  WelcomeScreen({Key? key, this.userPin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      pageBuilder: (context, animation1, animation2) => Menu(),
                      transitionsBuilder: (context, animation1, animation2, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation1.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
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
