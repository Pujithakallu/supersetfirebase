// lib/gamescreen/mathmingle/menu.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'score_topbar.dart';
import 'homescreen.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';
// Import main.dart so that WelcomeScreen is defined.
import 'package:supersetfirebase/gamescreen/mathmingle/main.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);

  final double buttonSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Let content extend behind AppBar.
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopBarWithScore(
          onBack: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Decoration
          Container(
            decoration: const BoxDecoration(
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
          ),
           Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adjust spacing between buttons dynamically based on screen size
              SizedBox(height: (MediaQuery.of(context).size.height * 0.05).clamp(10.0, 40.0)),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildChapterButton(context, 'C H A P T E R   1', 1, 'Numbers'),
                  SizedBox(width: (MediaQuery.of(context).size.width * 0.05).clamp(10.0, 30.0)),
                  buildChapterButton(context, 'C H A P T E R   2', 2, 'Foundations'),
                  SizedBox(width: (MediaQuery.of(context).size.width * 0.05).clamp(10.0, 30.0)),
                  buildChapterButton(context, 'C H A P T E R   3', 3, 'Shapes'),
                ],
              ),
              
              // Adjust spacing dynamically
              SizedBox(height: (MediaQuery.of(context).size.height * 0.08).clamp(10.0, 40.0)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildChapterButton(context, 'C H A P T E R   4', 4, 'Symbols'),
                  SizedBox(width: (MediaQuery.of(context).size.width * 0.05).clamp(10.0, 30.0)),
                  buildChapterButton(context, 'C H A P T E R   5', 5, 'Geometry'),
                ],
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

double lerp(double minValue, double maxValue, double t) {
  return minValue + (maxValue - minValue) * t;
}

double getResponsiveValue(double screenWidth, double min, double max) {
  const minScreenWidth = 500;
  const maxScreenWidth = 1200;
  if (screenWidth <= minScreenWidth) return min;
  if (screenWidth >= maxScreenWidth) return max;
  final t = (screenWidth - minScreenWidth) / (maxScreenWidth - minScreenWidth);
  return lerp(min, max, t);
}

Widget buildChapterButton(
  BuildContext context,
  String title,
  int chapterNumber,
  String chapterName,
) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  // // Responsive scaling
final double buttonWidth = getResponsiveValue(screenWidth, 150, 300);
final double buttonHeight = getResponsiveValue(screenHeight, 70, 140);
final double titleFontSize = getResponsiveValue(screenWidth, 10, 27);
final double nameFontSize = getResponsiveValue(screenWidth, 10, 20);
final double borderRadius = getResponsiveValue(screenWidth, 100, 150);
final double borderWidth = getResponsiveValue(screenWidth, 2, 4);

  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/home', arguments: chapterNumber);
    },
    child: Container(
      width: buttonWidth,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: const BorderSide(color: Colors.transparent),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/home', arguments: chapterNumber);
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Allow flexibility
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add horizontal padding
                child: Text(
                  title,
                  style: TextStyle(fontSize: titleFontSize, color: Colors.black),
                  textAlign: TextAlign.center, // Center the text
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add horizontal padding
                child: Text(
                  chapterName,
                  style: TextStyle(fontSize: nameFontSize, color: Colors.black),
                  textAlign: TextAlign.center, // Center the text
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
