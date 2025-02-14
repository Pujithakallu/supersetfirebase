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
import '../../utils/util.dart';

void main() => runApp(Operators());

class Operators extends StatelessWidget {
  const Operators({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OP Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      routes: {
        '/level': (context) => PlayPage(),
      },
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // test();
    GlobalVariables.setLevelData();
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logout(context);
        },
        foregroundColor: Colors.black,
        backgroundColor: Colors.red,
        shape: const CircleBorder(),

        child: const Icon(Icons.clear, size: 40,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Mathoperations/home_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children :[
                  // SizedBox(height: 90),
                  Spacer(flex: 1),
                  ValueListenableBuilder<int>(
                    valueListenable: GlobalVariables.totalScore,
                    builder: (context, int score, child) {
                      return UserCard(
                       // username: GlobalVariables.userName,
                        // avatarUrl: "assets/Mathoperations/orange.png",
                        score: score,
                      );
                    },
                  ),
                  Spacer(flex: 1),
                  ImageBanner("assets/Mathoperations/heading.png", screenWidth/5, screenWidth/2.3),
                  Spacer(flex: 1),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children :[
                      // SizedBox(width: 400),
                      Spacer(flex: 2),
                      InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LearnPage()));
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: screenWidth/7,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightGreen,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlayPage()));
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: screenWidth/7,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.lightBlue,
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text('Quiz',
                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: screenWidth/30),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(flex: 2),
                      // SizedBox(width: 100),

                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => ScorePage(),
                      //       ),
                      //     );
                      //   },
                      //   borderRadius: BorderRadius.circular(30),
                      //   child: Container(
                      //     width: 200,
                      //     padding: const EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(30),
                      //       color: Colors.orange,
                      //     ),
                      //     child: const Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: <Widget>[
                      //         Text('Score',
                      //           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 40),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ]
                  ),
                  Spacer(flex: 2),

                ]
            ),
          )
      ),
    );

  }
}





// bottomNavigationBar: BottomNavigationBar(
//   type: BottomNavigationBarType.fixed,
//   backgroundColor: Colors.black87,
//   currentIndex: 0,
//   items: [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.home, color: Colors.white,),
//       label: 'Home',
//       backgroundColor: Colors.white
//     ),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.access_alarm, color: Colors.white),
//         label: 'Home'
//     ),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.access_time_filled_outlined, color: Colors.white),
//         label: 'Home',
//         backgroundColor: Colors.black38
//     ),
//   ],
// ),