import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/image.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/color.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/learn_main.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/Score_page.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/Quiz_page.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/Play_Page.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/widgets/user_card.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/global.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/api/api_util.dart';
import 'package:supersetfirebase/screens/home_screen.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/services/firestore_score.dart';


class Operators extends StatelessWidget {
  final String userPin;

  const Operators({
    required this.userPin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OP Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(pin: userPin),
      routes: {
        '/level': (context) => PlayPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final String pin;

  const HomePage({
    required this.pin,
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? bestScore;
  final FirestoreService _firestoreService = FirestoreService();

  void _loadMathOperatorsScore() async {
    print("loading score inside function");
    int score = await _firestoreService.getUserScoreForGame(widget.pin, 'MathOperators');
    setState(() {
      bestScore = score;
    });
  }

  @override
  void initState() {
    super.initState();
    GlobalVariables.totalScore.value = 0; // Reset session score on entry
    // _resetScore(); // <-- temp for testing
    _loadMathOperatorsScore();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMathOperatorsScore();
  }

  // void _resetScore() async {
  //   await _firestoreService.updateUserScoreForGame(widget.pin, 'MathOperators', 0);
  // }

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    GlobalVariables.setLevelData();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseScale = (screenWidth + screenHeight) / 2;
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          //backbutton
          Positioned(
            left: 16,
            top: 16,
            child: FloatingActionButton(
              heroTag: "backButton",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(pin: userPin)),
                );
                _loadMathOperatorsScore();
              },
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back_rounded,
                  size: 32, color: Colors.black),
            ),
          ),
          // Logout button
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: "logoutButton",
              onPressed: () => logout(context),
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.logout_rounded,
                  size: 32, color: Colors.black),
            ),
          ),
          Positioned(
            right: 0,
            top:
                90, // Adjust this value as needed to position below the logout button
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ValueListenableBuilder<int>(
                valueListenable: GlobalVariables.totalScore,
                builder: (context, int score, child) {
                  return Text(
                    'Score: $bestScore',
                    style: TextStyle(
                      fontSize:
                          baseScale * 0.02, // Adjusted font size for visibility
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 33, 140, 101),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Mathoperations/BackGround_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // PIN
            Container(
              margin: EdgeInsets.only(top: 90),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'PIN: ${widget.pin}',
                style: TextStyle(
                  fontSize:  baseScale * 0.02,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 33, 140, 101),
                ),
              ),
            ),
            SizedBox(height: (screenHeight * 0.07).clamp(20.0, 80.0)),
            // OPERATORS text inside a styled box
            Container(
              // width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric( horizontal: (baseScale * 0.04).clamp(12.0, 24.0),
    vertical: (baseScale * 0.015).clamp(6.0, 16.0),),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 0, 0, 0), // Shadow for depth
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                "OPERATORS",
                style: TextStyle(
                  fontSize:(baseScale * 0.066).clamp(22.0, 34.0),
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(
                      255, 33, 140, 101), // Text color inside the white box
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Spacer(flex: 1),
                    // ValueListenableBuilder<int>(
                    //   valueListenable: GlobalVariables.totalScore,
                    //   builder: (context, int score, child) {
                    //     return UserCard(
                    //       score: score,
                    //     );
                    //   },
                    // ),
                    // Spacer(flex: 1),
                    // ImageBanner("assets/Mathoperations/heading.png",
                    //     screenWidth / 5, screenWidth / 2.3),
                    Spacer(flex: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spacer(flex: 2),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LearnPage()));
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: screenWidth / 7,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 239, 80, 91),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 239, 80, 91)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withAlpha(128), // Shadow color
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 2), // Shadow position
                                ),
                              ],
                              // color: Colors.lightGreen,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Learn',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:  baseScale * 0.025),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PlayPage()),
                            );

                            if (result == 'refresh') {
                              _loadMathOperatorsScore();
                            }
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: screenWidth / 7,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 237, 214, 111),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 237, 214, 111)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withAlpha(128), // Shadow color
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Play',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: baseScale * 0.025),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                    Spacer(flex: 2),
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

