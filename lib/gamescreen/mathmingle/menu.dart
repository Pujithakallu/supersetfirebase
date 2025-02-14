import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'matching.dart';
import 'memory.dart';
import 'package:provider/provider.dart';
import '../../utils/util.dart';

// void main() {
//   runApp(MaterialApp(
//     home: Menu(),
//   ));
// }

class Menu extends StatelessWidget {
  // Customize the spacing between each option
  final double buttonSpacing = 20.0;
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? total = 1;
    int? total1 = 2;
    int? GT = total + total1;
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
              // Display the total value in a styled card
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
              SizedBox(height: buttonSpacing * 0.5), // Adjusted spacing
              // Row 1
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildChapterButton(context, 'C H A P T E R   1',1, 'Numbers',  Colors.white),
                  SizedBox(width: buttonSpacing),
                  buildChapterButton(context, 'C H A P T E R   2', 2,'Foundations',  Colors.white),
                  SizedBox(width: buttonSpacing),
                  buildChapterButton(context, 'C H A P T E R   3', 3 ,'Shapes', Colors.white),
                ],
              ),
              SizedBox(height: buttonSpacing), // Spacing between rows
              // Row 2
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildChapterButton(context, 'C H A P T E R   4', 4,'Symbols',  Colors.white),
                  SizedBox(width: buttonSpacing),
                  buildChapterButton(context, 'C H A P T E R   5',5, 'Geometry',  Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildChapterButton(BuildContext context, String title,int chapterNumber, String chapterName, Color color) {
    return GestureDetector(
      onTap: () {
        print("Navigating to /home with chapterNumber: $chapterNumber");

        Navigator.pushNamed(context, '/home',arguments:chapterNumber ?? 1);
      },
      child: Container(
        width: 300, // Set width for consistency
        height: 120, // Set height for consistency
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 4), // Thicker gray border
          borderRadius: BorderRadius.circular(150),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                minimumSize: Size(double.infinity, double.infinity), // Make button fill the container
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150),
                  side: BorderSide(color: Colors.transparent), // No internal border
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home',arguments:chapterNumber);
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