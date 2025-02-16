import 'package:flutter/material.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/widgets/answer_card.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/operator_data/op_data.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/flash_cards/flash_cards.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class SingleQuestionPage extends StatelessWidget {
  final Map<String, dynamic> questionData;
  final String questionType;
  const SingleQuestionPage({
    Key? key,
    required this.questionData,
    required this.questionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? selectedAnswerIndex = questionData['selected_ans_index'] ?? 0;
    int correctAnswerIndex = questionData['correct_ans_index'] ?? 0;
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
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
              child: const Icon(Icons.arrow_back_ios, size: 24),
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
        padding: const EdgeInsets.fromLTRB(50, 70, 50, 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  padding: EdgeInsets.all(10),
                  child: Text(questionData['question'],
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            (questionType == 'mcq') || (questionType == 'mcq_img')
                ? Expanded(
                    child: ListView.builder(
                      itemCount: questionData['options'].length,
                      itemBuilder: (context, index) {
                        return AnswerCard(
                          question: questionData['options'][index][0],
                          isSelected: selectedAnswerIndex == index,
                          currentIndex: index,
                          correctAnswerIndex: correctAnswerIndex,
                          selectedAnswerIndex: selectedAnswerIndex,
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Column(children: [
                      AnswerCard(
                        question:
                            "Correct Answer:    ${questionData['correctAnswer']}",
                        isSelected: true,
                        currentIndex: 0,
                        correctAnswerIndex: 0,
                        selectedAnswerIndex: 0,
                      ),
                      AnswerCard(
                        question:
                            "Your Response:     ${questionData['enteredAnswer']}",
                        isSelected: true,
                        currentIndex: 0,
                        correctAnswerIndex: questionData['enteredAnswer'] ==
                                questionData['correctAnswer']
                            ? 0
                            : 1, // if the correct ans and selected ans is same then green else red
                        selectedAnswerIndex: 0,
                      ),
                    ]),
                  ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FlashCard(
                              opSign: questionData["sign"],
                            )));
              },
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 200,
                // height: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.lightBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Learn  ' + questionData["sign"] + '',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
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
