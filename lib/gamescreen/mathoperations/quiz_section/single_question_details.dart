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
    super.key,
    required this.questionData,
    required this.questionType,
  });

  @override
  Widget build(BuildContext context) {
    int? selectedAnswerIndex = questionData['selected_ans_index'] ?? 0;
    int correctAnswerIndex = questionData['correct_ans_index'] ?? 0;
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                mini: true, // Smaller button
                child: const Icon(Icons.arrow_back_rounded,
                    size: 32, color: Colors.black),
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
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)),
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
