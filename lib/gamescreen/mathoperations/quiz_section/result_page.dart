import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/details_page.dart';

class ResultsPage extends StatelessWidget {
  final int correctAnswersCount;
  final int totalQuestions;
  final int score;
  final List<Map<String, dynamic>> questionResults;
  final String questionType;

  const ResultsPage({
    Key? key,
    required this.correctAnswersCount,
    required this.totalQuestions,
    required this.score,
    required this.questionResults,
    required this.questionType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
            image: AssetImage('assets/Mathoperations/background.png'), // Assuming you have a similar background
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
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 50,),
                Card(
                  elevation: 5, // Adding some elevation for shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white70, // Taken from the FlashCard back card
                  child: Padding(
                    padding: const EdgeInsets.all(70.0), // From FlashCard back padding
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Total Questions: $totalQuestions", style: TextStyle(fontSize: (screenWidth / 25).clamp(16.0, 30.0), color: Colors.black87)),
                        SizedBox(height: 5),
                        Text("Correct Answers: $correctAnswersCount", style: TextStyle(fontSize: (screenWidth / 25).clamp(16.0, 30.0), color: Colors.black87)),
                        SizedBox(height: 5),
                        Text("Your Score: $score", style: TextStyle(fontSize: (screenWidth / 20).clamp(16.0, 40.0), fontWeight: FontWeight.bold, color: Colors.black)),
                        SizedBox(height: 10),
                        InkWell(
                          // onTap: () => Navigator.popUntil(context, ModalRoute.withName('/level')),

                          onTap: () {
                            Navigator.popUntil(context, ModalRoute.withName('/'));
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Back to Level',
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsPage(questionResults: questionResults,questionType: questionType,),),);
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Details',
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 25),
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
            )
          ),
        ),
      ),
    );
  }
}
