// main.dart (your current implementation is correct)
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supersetfirebase/screens/home_screen.dart' as main_home;
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart' as game_home;
import 'package:supersetfirebase/widgets/appbarwelcomepage.dart'; 
import 'homescreen.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/mathminglemenu.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/studymaterial.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/matching.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart';
import 'package:provider/provider.dart';

// State management classes
class GameData extends ChangeNotifier {
  int _total = 0;
  int get total => _total;
  void updateTotal(int value) {
    _total = value;
    notifyListeners();
  }
}

class GameData1 extends ChangeNotifier {
  int _total = 0;
  int get total => _total;
  void updateTotal(int value) {
    _total = value;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameData()),
        ChangeNotifierProvider(create: (_) => GameData1()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MathMingle',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MathmingleMain(userPin: ''),
          '/mathminglemenu': (context) => Mathminglemenu(),
          '/home': (context) => MyHomePage(),
          '/studymaterial': (context) => StudyMaterialScreen(),
          '/matching': (context) => MatchGame(),
          '/memory': (context) => MemoryGame(),
        },
      ),
    ),
  );
}

// Your ResponsiveBuilder class remains the same
class ResponsiveBuilder {
  static double getWelcomeFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return width * 0.15;
    if (width < 1200) return width * 0.12;
    return width * 0.1;
  }

  static double getButtonWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return width * 0.8;
    if (width < 1200) return width * 0.6;
    return width * 0.4;
  }

  static double getButtonHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.08;
  }

  static double getVerticalSpacing(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.15;
  }
}

// Your MathmingleMain class implementation remains the same
class MathmingleMain extends StatelessWidget {
  final String userPin;
  
  const MathmingleMain({Key? key, required this.userPin}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context) async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: CustomGameAppBar(
          userPin: userPin,
          title: 'MathMingle',
          showHomeButton: true,
        ),
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
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.03,
                          vertical: screenSize.height * 0.02,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'W E L C O M E',
                            style: TextStyle(
                              fontSize: ResponsiveBuilder.getWelcomeFontSize(context),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ResponsiveBuilder.getVerticalSpacing(context)),
                      SizedBox(
                        width: ResponsiveBuilder.getButtonWidth(context),
                        height: ResponsiveBuilder.getButtonHeight(context),
                        child: ElevatedButton(
                          onPressed: () => _navigateToMenu(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: Colors.white, width: 2),
                            ),
                            elevation: 5,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'LET\'S DIVE IN !!!!!!',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 24 : 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMenu(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => Mathminglemenu(),
        transitionsBuilder: (context, animation1, animation2, child) {
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
        transitionDuration: Duration(milliseconds: 500),
        fullscreenDialog: true,
      ),
    );
  }
}