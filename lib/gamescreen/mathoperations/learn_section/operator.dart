import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/flash_cards/flash_cards.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/image.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/practice_section/practice_screen.dart';
import '../../../utils/util.dart';

class OperatorPage extends StatelessWidget {
  final Map<String, dynamic> operatorData;

  OperatorPage({required this.operatorData});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        foregroundColor: Colors.black,
        backgroundColor: Colors.lightBlue,
        shape: CircleBorder(),

        child: const Icon(Icons.arrow_back_ios),
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
                children :[
                  Spacer(flex: 2),
                  // ImageBanner('assets/Mathoperations/plus.png', 300, 250),
                  Text(
                    operatorData['op_sign'],
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth/10,
                      height: 0.8,
                    ),
                  ),
                  Text(
                    operatorData['op_name'],
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                      fontSize: screenWidth/15,
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

                      children :[
                        Spacer(flex: 1),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FlashCard(opSign: operatorData['op_sign'] ,)));
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: screenWidth/5,
                            // height: screenWidth/15,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightGreen,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Learn',
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: screenWidth/30),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PracticeScreen(opSign: operatorData['op_sign'],)));
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: screenWidth/5,
                            // height: screenWidth/15,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightBlue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Practice',
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: screenWidth/30),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                      ]
                  ),
                  Spacer(flex: 3),
                ]
            ),
          )
      ),
    );

  }
}