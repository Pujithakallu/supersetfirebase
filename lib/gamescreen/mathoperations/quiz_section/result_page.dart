import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/details_page.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class ResultsPage extends StatelessWidget {
  final int correctAnswersCount;
  final int totalQuestions;
  final int score;
  final List<Map<String, dynamic>> questionResults;
  final String questionType;

  const ResultsPage(
      {Key? key,
      required this.correctAnswersCount,
      required this.totalQuestions,
      required this.score,
      required this.questionResults,
      required this.questionType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
              child: const Icon(Icons.arrow_back_rounded, size: 24),
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/Mathoperations/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(70.0),
              child: Column(
                children: [
                  Text(
                    'Result',
                    style: TextStyle(
                        fontSize: (screenWidth / 10).clamp(16.0, 40.0),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Card(
                    elevation: 5, // Adding some elevation for shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.white70, // Taken from the FlashCard back card
                    child: Padding(
                      padding: const EdgeInsets.all(
                          70.0), // From FlashCard back padding
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Total Questions: $totalQuestions",
                              style: TextStyle(
                                  fontSize:
                                      (screenWidth / 25).clamp(16.0, 30.0),
                                  color: Colors.black87)),
                          SizedBox(height: 5),
                          Text("Correct Answers: $correctAnswersCount",
                              style: TextStyle(
                                  fontSize:
                                      (screenWidth / 25).clamp(16.0, 30.0),
                                  color: Colors.black87)),
                          SizedBox(height: 5),
                          Text("Your Score: $score",
                              style: TextStyle(
                                  fontSize:
                                      (screenWidth / 20).clamp(16.0, 40.0),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          SizedBox(height: 10),
                          InkWell(
                            // onTap: () => Navigator.popUntil(context, ModalRoute.withName('/level')),

                            onTap: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                              Navigator.pushNamed(context, '/level');
                            },

                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 200,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.lightBlue,
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Back to Level',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    questionResults: questionResults,
                                    questionType: questionType,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 200,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.green,
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Details',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.red,
                          //     foregroundColor: Colors.white,
                          //     textStyle: TextStyle(fontSize: 20),
                          //     padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                          //   ),
                          //   child: Text("Back to Home", style: TextStyle(fontSize: 20)),
                          // ),
                          // SizedBox(height: 10),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsPage(questionResults: questionResults),),);
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.blueAccent,
                          //     foregroundColor: Colors.white,
                          //     textStyle: TextStyle(fontSize: 20),
                          //     padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                          //   ),
                          //   child: Text("Details", style: TextStyle(fontSize: 20)),
                          // ),
                          // Add the "Details" button or other UI elements as needed
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
