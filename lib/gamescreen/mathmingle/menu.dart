import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'matching.dart';
import 'memory.dart';
import 'package:provider/provider.dart';
import '../../utils/util.dart';

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
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () => logout(context),
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
