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
          // Centered chapter selection buttons.
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: buttonSpacing * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildChapterButton(context, 'C H A P T E R   1', 1, 'Numbers'),
                    SizedBox(width: buttonSpacing),
                    buildChapterButton(context, 'C H A P T E R   2', 2, 'Foundations'),
                    SizedBox(width: buttonSpacing),
                    buildChapterButton(context, 'C H A P T E R   3', 3, 'Shapes'),
                  ],
                ),
                SizedBox(height: buttonSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildChapterButton(context, 'C H A P T E R   4', 4, 'Symbols'),
                    SizedBox(width: buttonSpacing),
                    buildChapterButton(context, 'C H A P T E R   5', 5, 'Geometry'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // Floating logout button at bottom right.
      floatingActionButton: FloatingActionButton(
        onPressed: () => logout(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.logout_rounded, size: 28, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildChapterButton(
    BuildContext context,
    String title,
    int chapterNumber,
    String chapterName,
  ) {
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(fontSize: 27, color: Colors.black)),
              Text(chapterName, style: const TextStyle(fontSize: 20, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
