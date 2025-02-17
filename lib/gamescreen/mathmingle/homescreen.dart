import 'package:flutter/material.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  final int chapterNumber;

  const MyHomePage({Key? key, required this.chapterNumber}) : super(key: key);

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = 'XYZ';

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => Navigator.pop(context),
              foregroundColor: Colors.black,
              backgroundColor: Colors.lightBlue,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back_ios, size: 24),
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
        width: MediaQuery.of(context).size.width, // Full screen width
        height: MediaQuery.of(context).size.height, // Full screen height
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
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Mathmingle/NoPic.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome $userPin',
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
                      widget.chapterNumber,
                      20, // Example points
                    ),
                    buildGameCard(
                      context,
                      'Jungle Matching Safari\n', // Force two lines
                      'assets/Mathmingle/homescreen/level_2.png',
                      'Match and test your memory in the wild jungle themed drag and drop game.',
                      '/matching',
                      widget.chapterNumber,
                      30, // Example points
                    ),
                    buildGameCard(
                      context,
                      'Remember & Win\n', // Force two lines
                      'assets/Mathmingle/homescreen/level_3.png',
                      'Boost your memory with this exciting matching tile game and earn rewards.',
                      '/memory',
                      widget.chapterNumber,
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

  Widget buildGameCard(BuildContext context, String title, String imagePath,
      String description, String route, int chapter, int points) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route, arguments: widget.chapterNumber);
      },
      child: Container(
        width: 250, // Set a fixed width for each card
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  // Center the heading text horizontally
                  child: Text(
                    title,
                    maxLines: 2, // Ensure the text takes up 2 lines
                    overflow: TextOverflow
                        .ellipsis, // Ellipsis if content is too long
                    textAlign: TextAlign.center, // Center the text
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
                        fit: BoxFit.cover, // Make the image fit completely
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
                  textAlign: TextAlign.justify, // Justify the text
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
