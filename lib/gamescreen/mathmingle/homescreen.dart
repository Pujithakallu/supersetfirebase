// homescreen.dart (assuming MyHomePage is here)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/matching.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart';
import 'score_topbar.dart';

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
      // Use our top bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopBarWithScore(
          onBack: () => Navigator.pop(context), // or whatever you want
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, 
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Top section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Mathmingle/NoPic.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Welcome ${Provider.of<UserPinProvider>(context, listen: false).pin}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal Cards
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    buildGameCard(
                      context,
                      'Learn\n',
                      'assets/Mathmingle/homescreen/level_1.png',
                      'Learn new words and numbers...',
                      '/studymaterial',
                      widget.chapterNumber,
                      20,
                    ),
                    buildGameCard(
                      context,
                      'Jungle Matching Safari\n',
                      'assets/Mathmingle/homescreen/level_2.png',
                      'Match and test your memory...',
                      '/matching',
                      widget.chapterNumber,
                      30,
                    ),
                    buildGameCard(
                      context,
                      'Remember & Win\n',
                      'assets/Mathmingle/homescreen/level_3.png',
                      'Boost your memory...',
                      '/memory',
                      widget.chapterNumber,
                      40,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildGameCard(
    BuildContext context,
    String title,
    String imagePath,
    String description,
    String route,
    int chapter,
    int points,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route, arguments: chapter);
      },
      child: Container(
        width: 250,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                        style: const TextStyle(
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
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
