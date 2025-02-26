import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'matching.dart';
import 'memory.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/main.dart';

// Assume GameData and GameData1 are defined and provided by the MultiProvider in MathMingleApp

class Menu extends StatelessWidget {
  // Customize the spacing between each option
  final double buttonSpacing = 20.0;

  // Remove the const keyword from the constructor.
  Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access provider values
    int total = Provider.of<GameData>(context).total;
    int total1 = Provider.of<GameData1>(context).total;
    int GT = total + total1;
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    return Scaffold(
      floatingActionButton: Positioned(
        top: 16,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back Button (Left)
            FloatingActionButton(
              heroTag: "backButton",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              foregroundColor: Colors.black,
              backgroundColor: Colors.lightBlue,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back_rounded, size: 24),
            ),

            // PIN Display (Center)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'PIN: $userPin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // Logout Button (Right)
            Padding(
              padding: EdgeInsets.only(
                  right: 30), // Moves logout button slightly left
              child: FloatingActionButton(
                heroTag: "logoutButton",
                onPressed: () => logout(context),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                child:
                    const Icon(Icons.logout_rounded, size: 28), // Larger icon
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
                    style: const TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: buttonSpacing * 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildChapterButton(
                      context, 'C H A P T E R   1', 1, 'Numbers', Colors.white),
                  SizedBox(width: buttonSpacing),
                  buildChapterButton(context, 'C H A P T E R   2', 2,
                      'Foundations', Colors.white),
                  SizedBox(width: buttonSpacing),
                  buildChapterButton(
                      context, 'C H A P T E R   3', 3, 'Shapes', Colors.white),
                ],
              ),
              SizedBox(height: buttonSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildChapterButton(
                      context, 'C H A P T E R   4', 4, 'Symbols', Colors.white),
                  SizedBox(width: buttonSpacing),
                  buildChapterButton(context, 'C H A P T E R   5', 5,
                      'Geometry', Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChapterButton(BuildContext context, String title,
      int chapterNumber, String chapterName, Color color) {
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
                minimumSize: const Size(double.infinity, double.infinity),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150),
                  side: const BorderSide(color: Colors.transparent),
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
                      style: const TextStyle(fontSize: 27, color: Colors.black),
                    ),
                    Text(
                      chapterName,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
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
