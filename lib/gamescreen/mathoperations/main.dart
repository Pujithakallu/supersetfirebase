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
import '../../utils/logout_util.dart';

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
  @override
  Widget build(BuildContext context) {
    GlobalVariables.setLevelData();
    double screenWidth = MediaQuery.of(context).size.width;
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
                      builder: (context) => HomeScreen(pin: widget.pin)),
                );
              },
              foregroundColor: Colors.black,
              backgroundColor: Colors.lightBlue,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back_ios, size: 32),
            ),
          ),
          // Logout button
          Positioned(
            right: 0,
            top: 0,
            child: FloatingActionButton(
              heroTag: "logoutButton",
              onPressed: () => logout(context),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              child: const Icon(Icons.logout_rounded, size: 32),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Mathoperations/home_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // PIN
            Container(
              margin: EdgeInsets.only(top: 80),
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
                'PIN: ${widget.pin}',
                style: TextStyle(
                  fontSize: screenWidth / 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 1),
                    ValueListenableBuilder<int>(
                      valueListenable: GlobalVariables.totalScore,
                      builder: (context, int score, child) {
                        return UserCard(
                          score: score,
                        );
                      },
                    ),
                    Spacer(flex: 1),
                    ImageBanner("assets/Mathoperations/heading.png",
                        screenWidth / 5, screenWidth / 2.3),
                    Spacer(flex: 1),
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
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: screenWidth / 7,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightGreen,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Learn',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth / 30),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayPage()));
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: screenWidth / 7,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightBlue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Quiz',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth / 30),
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
