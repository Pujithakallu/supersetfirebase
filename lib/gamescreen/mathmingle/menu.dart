// menu.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/matching.dart' show GameData;
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart' show GameData1;
import 'score_topbar.dart'; // The widget we created
import 'homescreen.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/main.dart'; // Possibly needed?

import 'main.dart'; // for WelcomeScreen

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);

  // Customize the spacing between each option
  final double buttonSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    // Entire top bar is now replaced by TopBarWithScore
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopBarWithScore(
          onBack: () {
            // If you want to go to the WelcomeScreen:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          // your background
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

          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // If you still want a "TOTAL: GT" card or remove it
                // Actually we show Score in top bar, so you might remove this
                // But if you do want an extra big "TOTAL: X" here, do so:
                // ...
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
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
                    Text(title,
                        style: const TextStyle(fontSize: 27, color: Colors.black)),
                    Text(chapterName,
                        style: const TextStyle(fontSize: 20, color: Colors.black)),
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
