import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homescreen.dart';
import 'package:supersetfirebase/screens/home_screen.dart' as main_home;
import 'matching.dart';
import 'memory.dart';

// Add GameData classes
class GameData extends ChangeNotifier {
  int _total = 0;
  int get total => _total;
  
  void updateTotal(int newTotal) {
    _total = newTotal;
    notifyListeners();
  }
}

class GameData1 extends ChangeNotifier {
  int _total = 0;
  int get total => _total;
  
  void updateTotal(int newTotal) {
    _total = newTotal;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameData()),
        ChangeNotifierProvider(create: (_) => GameData1()),
      ],
      child: MaterialApp(
        home: Mathminglemenu(),
        routes: {
          '/home': (context) => HomeScreen(), // Make sure this exists
        },
      ),
    ),
  );
}

class Mathminglemenu extends StatelessWidget {
  final double buttonSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to both providers
    return Consumer2<GameData, GameData1>(
      builder: (context, gameData, gameData1, child) {
        final int GT = gameData.total + gameData1.total;
        
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Mathmingle/menu.jpeg'),
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
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'T O T A L : $GT',
                        style: TextStyle(fontSize: 24, color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(height: buttonSpacing * 0.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildChapterButton(context, 'C H A P T E R   1', 1, 'Numbers', Colors.white),
                      SizedBox(width: buttonSpacing),
                      buildChapterButton(context, 'C H A P T E R   2', 2, 'Foundations', Colors.white),
                      SizedBox(width: buttonSpacing),
                      buildChapterButton(context, 'C H A P T E R   3', 3, 'Shapes', Colors.white),
                    ],
                  ),
                  SizedBox(height: buttonSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildChapterButton(context, 'C H A P T E R   4', 4, 'Symbols', Colors.white),
                      SizedBox(width: buttonSpacing),
                      buildChapterButton(context, 'C H A P T E R   5', 5, 'Geometry', Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildChapterButton(BuildContext context, String title, int chapterNumber, String chapterName, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/home', arguments: chapterNumber);
      },
      child: Container(
        width: 300,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 4),
          borderRadius: BorderRadius.circular(150),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                minimumSize: Size(double.infinity, double.infinity),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150),
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home', arguments: chapterNumber);
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 27, color: Colors.black),
                    ),
                    Text(
                      chapterName,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}