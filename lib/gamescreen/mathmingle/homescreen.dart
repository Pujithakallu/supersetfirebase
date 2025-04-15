// lib/gamescreen/mathmingle/homescreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/matching.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart';
import 'score_topbar.dart';
import 'studymaterial.dart';
//import 'package:auto_size_text/auto_size_text.dart';

class MyHomePage extends StatefulWidget {
  final int chapterNumber;
  const MyHomePage({Key? key, required this.chapterNumber}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = 'XYZ';

  @override
  Widget build(BuildContext context) {
final screenWidth = MediaQuery.of(context).size.width;
  final bool isSmallScreen = screenWidth < 600; // You can adjust this threshold


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopBarWithScore(
          onBack: () => Navigator.pop(context),
        ),
      ),
      
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Mathmingle/homescreen/Learn_page.png"),
            fit: BoxFit.scaleDown,
          ),
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight + 20), // Adjusted for AppBar spacing
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Math Mingle',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 30 : 44,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isSmallScreen ? 4 : 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MathMingleLearnPage(chapterNumber: widget.chapterNumber),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 8 : 16,
                        horizontal: isSmallScreen ? 15 : 32,
                      ),
                      textStyle: TextStyle(fontSize: isSmallScreen ? 16 : 24),
                      elevation: 6,
                    ),
                    child: const Text('Learn'),
                  ),
                  SizedBox(height: isSmallScreen ? 10 : 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MathMinglePlayPage(chapterNumber: widget.chapterNumber),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                       padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 8 : 16,
                        horizontal: isSmallScreen ? 15 : 32,
                      ),
                      textStyle: TextStyle(fontSize: isSmallScreen ? 16 : 24),
                      elevation: 6,
                    ),
                    child: const Text('Play'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MathMingleLearnPage extends StatelessWidget {
  final int chapterNumber;
  const MathMingleLearnPage({Key? key, required this.chapterNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 700;

    // Scale factor (1.0 = full size; <1 = scaled down)
    final double scaleFactor = isSmallScreen ? screenWidth / 700 : 1.0;

   final double cardWidth = isSmallScreen ? 200 : 300; // 200 for small screen, 300 for large
    final double cardHeight = isSmallScreen ? 200 : 400; // 200 for small screen, 400 for large

    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
     
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    fontSize: 16 * scaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
             SizedBox(height: isSmallScreen ? 0 : 20),
            Center(
              child: Text(
                "Math Mingle",
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? 0 : 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double screenWidth = constraints.maxWidth;

                // Total width of both cards + spacing
                final double totalCardsWidth = cardWidth * 2 + 12; 

                // Calculate scale factor if the screen width is less than total width of cards
                final double scaleFactor = screenWidth < totalCardsWidth
                    ? screenWidth / totalCardsWidth
                    : 1.0;

                return Center(
                    child: Transform.scale(
                      scale: scaleFactor, // Adjust this scaleFactor to fit your needs
                      alignment: Alignment.topCenter,
                      child: buildGameCard(
                        context,
                        'Learn', // Title
                        'assets/Mathmingle/homescreen/level_1.png', // Image path
                        'Learn new words and numbers. Use your gained knowledge to win points in learning-based games.',
                        '/studymaterial', // Route
                        chapterNumber, // Chapter number
                        20, // Points
                        cardHeight: cardHeight, // Adjust height
                        cardWidth: cardWidth, // Adjust width
                      ),
                    ),
                  );
              },
            ),
             ),
          ],
        ),
      ),
    );
  }
}

class MathMinglePlayPage extends StatelessWidget {
  final int chapterNumber;
  const MathMinglePlayPage({Key? key, required this.chapterNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 700;
    final double scaleFactor = isSmallScreen ? screenWidth / 900 : 1.0;

   // Define card dimensions based on screen size
    final double cardWidth = isSmallScreen ? 200 : 300; // 200 for small screen, 300 for large
    final double cardHeight = isSmallScreen ? 200 : 400; // 200 for small screen, 400 for large

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopBarWithScore(
          onBack: () => Navigator.pop(context),
        ),
      ),
      // Logout FAB
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Center(
              child: Text(
                "Math Mingle",
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? 0 : 20),
                Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double screenWidth = constraints.maxWidth;

                          // Total width of both cards + spacing
                          final double totalCardsWidth = cardWidth * 2 + 12; 

                          // Calculate scale factor if the screen width is less than total width of cards
                          final double scaleFactor = screenWidth < totalCardsWidth
                              ? screenWidth / totalCardsWidth
                              : 1.0;

                          return Center(
                            child: Transform.scale(
                              scale: scaleFactor,
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  buildGameCard(
                                    context,
                                    'Jungle Matching Safari\n',
                                    'assets/Mathmingle/homescreen/level_2.png',
                                    'Match and test your memory in the wild jungle-themed drag-and-drop game.',
                                    '/matching',
                                    chapterNumber,
                                    30,
                                    cardHeight: cardHeight,
                                    cardWidth: cardWidth,
                                  ),
                                  const SizedBox(width: 12),
                                  buildGameCard(
                                    context,
                                    'Remember & Win\n',
                                    'assets/Mathmingle/homescreen/level_3.png',
                                    'Boost your memory with this exciting matching tile game and earn rewards.',
                                    '/memory',
                                    chapterNumber,
                                    40,
                                    cardHeight: cardHeight,
                                    cardWidth: cardWidth,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            }
          }

// Top-level function to build a game card widget.
Widget buildGameCard(
  BuildContext context,
  String title,
  String imagePath,
  String description,
  String route,
  int chapter,
  int points, {
  double cardWidth = 250,
  double cardHeight = 350,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, route, arguments: chapter);
    },
    child: Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          Navigator.pushNamed(context, route, arguments: chapter);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          ),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(11.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width < 700 
                          ? 14 // smaller font size for small screens
                          : 22, // larger font size for larger screens
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 700 ? 0 : 10,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width < 700 ? 80 : 150,
                        fit: BoxFit.cover,
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
                
                 SizedBox(
                  height: MediaQuery.of(context).size.width < 700 ? 0 : 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width < 700 ? 10 : 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
