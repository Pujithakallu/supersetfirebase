import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'homescreen.dart';
import 'menu.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/screens/home_screen.dart' as home;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MathMingleApp());
}

class MathMingleApp extends StatelessWidget {
  const MathMingleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameData()),
        ChangeNotifierProvider(create: (_) => GameData1()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/menu': (context) => Menu(),
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
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;

    return Scaffold(
      body: Stack(
        children: [
          // Background Decoration
          Container(
            decoration: const BoxDecoration(
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
                      fontSize: (MediaQuery.of(context).size.width * 0.1)
                          .clamp(50.0, 140.0), // Scales within a range
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height *
                            (MediaQuery.of(context).size.height > 700
                                ? 0.3
                                : 0.1))
                        .clamp(10.0, 300.0),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              Menu(),
                          transitionsBuilder:
                              (context, animation1, animation2, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
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
                      minimumSize: Size(
                        MediaQuery.of(context).size.width *
                            0.8, // Dynamically adjusts based on screen width
                        MediaQuery.of(context).size.height *
                            0.08, // Dynamically adjusts based on screen height
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: Text(
                      'LET\'S DIVE IN !!!!!!',
                      style: TextStyle(
                        fontSize: (MediaQuery.of(context).size.width * 0.05)
                            .clamp(
                                5.0, 35.0), // Scales font size within a range
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Back button & PIN centered row at the top
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) {
                    final screenWidth = MediaQuery.of(context).size.width;

                    // Responsive values based on screen width
                    final double buttonSize = screenWidth < 600 ? 30 : 50;
                    final double iconSize = screenWidth < 600 ? 18 : 28;

                    return Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(
                        width: buttonSize,
                        height: buttonSize,
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            //Navigator.pushReplacement(
                            //context,
                            //MaterialPageRoute(
                            //  builder: (context) =>
                            //    home.HomeScreen(pin: userPin)),
                            //);
                          },
                          fillColor: Colors.lightBlue,
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          constraints: BoxConstraints.tightFor(
                            width: buttonSize,
                            height: buttonSize,
                          ),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: iconSize,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Center PIN (expanded center)
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final screenWidth = MediaQuery.of(context).size.width;

                      // Responsive values based on screen width
                      final double fontSize = screenWidth < 600 ? 12 : 16;
                      final double horizontalPadding =
                          screenWidth < 600 ? 10 : 16;
                      final double verticalPadding = screenWidth < 600 ? 6 : 8;
                      final double borderRadius = screenWidth < 600 ? 10 : 15;

                      return Center(
                        child: Transform.translate(
                          offset: const Offset(
                              -12, 0), // Move 12 logical pixels to the left
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                              vertical: verticalPadding,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(borderRadius),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'PIN: $userPin',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Logout FAB at bottom right
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.height > 700 ? 56 : 40,
        height: MediaQuery.of(context).size.height > 700 ? 56 : 40,
        child: FloatingActionButton(
          heroTag: "logoutButton",
          onPressed: () => logout(context),
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.logout_rounded,
            size: MediaQuery.of(context).size.height > 700 ? 28 : 20,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
