import 'package:flutter/material.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = 'XYZ';

  @override
  Widget build(BuildContext context) {
    final chapter = ModalRoute.of(context)?.settings.arguments as int? ?? 1;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the main menu
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,  // Full screen width
        height: MediaQuery.of(context).size.height,  // Full screen height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Top section with user icon and welcome text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Mathmingle/NoPic.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome $userName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Cards section with horizontal scroll
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    buildGameCard(
                      context,
                      'Learn\n', // Force two lines
                      'assets/Mathmingle/homescreen/level_1.png',
                      'Learn new words and numbers. Use your gained knowledge to win points in learning based games.',
                      '/studymaterial',
                      chapter,
                      20, // Example points
                    ),
                    buildGameCard(
                      context,
                      'Jungle Matching Safari\n', // Force two lines
                      'assets/Mathmingle/homescreen/level_2.png',
                      'Match and test your memory in the wild jungle themed drag and drop game.',
                      '/matching',
                      chapter,
                      30, // Example points
                    ),
                    buildGameCard(
                      context,
                      'Remember & Win\n', // Force two lines
                      'assets/Mathmingle/homescreen/level_3.png',
                      'Boost your memory with this exciting matching tile game and earn rewards.',
                      '/memory',
                      chapter,
                      40, // Example points
                    ),
                  ],
                ),
              ),
            ),

            // Add a SizedBox or Padding to create space between cards and bottom of the screen
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildGameCard(BuildContext context, String title, String imagePath, String description, String route, int chapter, int points) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route, arguments: chapter);
      },
      child: Container(
        width: 250,  // Set a fixed width for each card
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(  // Center the heading text horizontally
                  child: Text(
                    title,
                    maxLines: 2, // Ensure the text takes up 2 lines
                    overflow: TextOverflow.ellipsis, // Ellipsis if content is too long
                    textAlign: TextAlign.center,  // Center the text
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,  // Make the image fit completely
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(Icons.star, color: Colors.yellow[700]),
                    ),
                    Positioned(
                      top: 8,
                      right: 40,
                      child: Text(
                        '$points pts',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.justify,  // Justify the text
                  style: TextStyle(
                    fontSize: 16,
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