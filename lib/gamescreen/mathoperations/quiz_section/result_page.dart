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
    double baseScale = (screenWidth < screenHeight ? screenWidth : screenHeight) / 100;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Adjust AppBar height
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Transparent AppBar Layer
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false, // Prevents default back button
            ),

            // Back Button (Styled as FloatingActionButton)
            Positioned(
              left: 16,
              top: 12,
              child: FloatingActionButton(
                heroTag: "backButton",
                onPressed: () => Navigator.pop(context),
                foregroundColor: Colors.black,
                backgroundColor: Colors.lightBlue,
                shape: const CircleBorder(),
                mini: true, // Smaller button
                child: const Icon(Icons.arrow_back_rounded, size: 32),
              ),
            ),

            // PIN Display (Smaller Width, Centered)
            Positioned(
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6), // Reduced padding
                constraints: const BoxConstraints(
                  maxWidth:
                      120, // Limits the width to prevent it from being too wide
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12), // Slightly rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'PIN: $userPin',
                    style: const TextStyle(
                      fontSize: 14, // Slightly smaller font for better fit
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Mathoperations/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                  padding:  EdgeInsets.all((baseScale * 6).clamp(18.0, 70.0)),
                   child: SingleChildScrollView( 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Result',
                        style: TextStyle(
                            fontSize: (baseScale * 4).clamp(14.0, 40.0),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: (baseScale * 5).clamp(4.0, 80.0),
                      ),
                      Card(
                        elevation: 5, // Adding some elevation for shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors
                            .white70, // Taken from the FlashCard back card
                        child: Padding(
                          padding:  EdgeInsets.all(
                              (baseScale * 6).clamp(18.0, 70.0)), // From FlashCard back padding
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Total Questions: $totalQuestions",
                                  style: TextStyle(
                                      fontSize: (baseScale * 2).clamp(16.0, 30.0),
                                      color: Colors.black87)),
                              SizedBox(height: 5),
                              Text("Correct Answers: $correctAnswersCount",
                                  style: TextStyle(
                                      fontSize:(baseScale * 2).clamp(16.0, 30.0),
                                      color: Colors.black87)),
                              SizedBox(height: 5),
                              Text("Your Score: $score",
                                  style: TextStyle(
                                      fontSize:(baseScale * 2).clamp(16.0, 30.0),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              SizedBox(height: (baseScale * 1).clamp(8.0, 16.0)),
                              InkWell(
                                // onTap: () => Navigator.popUntil(context, ModalRoute.withName('/level')),

                                onTap: () {
                                  Navigator.pop(context); // Just pop ResultsPage and return to McqQuiz or TextQuiz
                                },


                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: (baseScale * 20).clamp(140.0, 240.0),
                                  padding:  EdgeInsets.all((baseScale * 1.5).clamp(8.0, 16.0)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.lightBlue,
                                  ),
                                  child:  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        'Back to Level',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: (baseScale * 2).clamp(13.0, 30.0),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: (baseScale * 2).clamp(10.0, 24.0)),
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
                                  width: (baseScale * 20).clamp(140.0, 240.0),
                                  padding:  EdgeInsets.all((baseScale * 1.5).clamp(8.0, 16.0)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.green,
                                  ),
                                  child:  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        'Details',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: (baseScale * 2).clamp(13.0, 30.0),),
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
                    ],),
                  )),
            ),
          ),
          // Logout Button (Styled as FloatingActionButton)
          Positioned(
            bottom: 16,
            right: 12,
            child: FloatingActionButton(
              heroTag: "logoutButton",
              onPressed: () => logout(context),
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              mini: true, // Smaller button
              child: const Icon(Icons.logout_rounded,
                  size: 32, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
