// lib/gamescreen/mathmingle/homescreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/matching.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart';
import 'score_topbar.dart';
import 'studymaterial.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true, // AppBar overlays background
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopBarWithScore(
          onBack: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logout(context),
        backgroundColor: Colors.white,
        child: const Icon(Icons.logout_rounded, size: 28, color: Colors.black),
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
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Control vertical spacing manually
            children: [
              SizedBox(
                  height:
                      120), // Extra top spacing so content doesn't interfere with the TopBar
              Text(
                'Math Mingle',
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Learn Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MathMingleLearnPage(
                          chapterNumber: widget.chapterNumber),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  textStyle: TextStyle(fontSize: 24),
                  elevation: 6,
                ),
                child: Text('Learn'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MathMinglePlayPage(
                          chapterNumber: widget.chapterNumber),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  textStyle: TextStyle(fontSize: 24),
                  elevation: 6,
                ),
                child: Text('Play'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MathMingleLearnPage extends StatelessWidget {
  final int chapterNumber;
  const MathMingleLearnPage({Key? key, required this.chapterNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;

    return Scaffold(
      extendBodyBehindAppBar: true, // AppBar overlays background
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logout(context),
        backgroundColor: Colors.white,
        child: const Icon(Icons.logout_rounded, size: 28, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          // Display the PIN in a centered container
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Math Mingle",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Center(
              child: buildGameCard(
                context,
                'Learn\n',
                'assets/Mathmingle/homescreen/level_1.png',
                'Learn new words and numbers. Use your gained knowledge to win points in learning-based games.',
                '/studymaterial',
                chapterNumber,
                20,
                cardHeight: 400,
                cardWidth: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MathMinglePlayPage extends StatelessWidget {
  final int chapterNumber;
  const MathMinglePlayPage({Key? key, required this.chapterNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // AppBar overlays background
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopBarWithScore(
          onBack: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logout(context),
        backgroundColor: Colors.white,
        child: const Icon(Icons.logout_rounded, size: 28, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              "Math Mingle",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildGameCard(
                          context,
                          'Jungle Matching Safari\n',
                          'assets/Mathmingle/homescreen/level_2.png',
                          'Match and test your memory in the wild jungle-themed drag-and-drop game.',
                          '/matching',
                          chapterNumber,
                          30,
                          cardHeight: 400,
                          cardWidth: 300,
                        ),
                        buildGameCard(
                          context,
                          'Remember & Win\n',
                          'assets/Mathmingle/homescreen/level_3.png',
                          'Boost your memory with this exciting matching tile game and earn rewards.',
                          '/memory',
                          chapterNumber,
                          40,
                          cardHeight: 400,
                          cardWidth: 300,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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
                SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
