import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/flash_cards/flash_cards.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/image.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/practice_section/practice_screen.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class OperatorPage extends StatelessWidget {
  final Map<String, dynamic> operatorData;

  OperatorPage({required this.operatorData});

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
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
              onPressed: () => Navigator.pop(context),
              foregroundColor: Colors.black,
              backgroundColor: Colors.lightBlue,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back_ios, size: 32),
            ),
          ),
          // Logout button
          Positioned(
            right: 30,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Mathoperations/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(flex: 2),
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
                      'PIN: ${userPin}',
                      style: TextStyle(
                        fontSize: screenWidth / 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // ImageBanner('assets/Mathoperations/plus.png', 300, 250),
                  Text(
                    operatorData['op_sign'],
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth / 10,
                      height: 0.8,
                    ),
                  ),
                  Text(
                    operatorData['op_name'],
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                      fontSize: screenWidth / 15,
                    ),
                  ),
                  Spacer(flex: 1),
                  // Row(
                  //   children: [
                  //     SizedBox(width: 35),
                  //     Text('DEFINATION : Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
                  //       style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 25),
                  //     ),
                  //   ],
                  // ),

                  Spacer(flex: 1),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spacer(flex: 1),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FlashCard(
                                          opSign: operatorData['op_sign'],
                                        )));
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: screenWidth / 5,
                            // height: screenWidth/15,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightGreen,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                    builder: (context) => PracticeScreen(
                                          opSign: operatorData['op_sign'],
                                        )));
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: screenWidth / 5,
                            // height: screenWidth/15,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightBlue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Practice',
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
                      ]),
                  Spacer(flex: 3),
                ]),
          )),
    );
  }
}
