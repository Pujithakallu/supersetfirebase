import 'package:flutter/material.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/widgets/answer_card.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/operator_data/op_data.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/flash_cards/flash_cards.dart';

class SingleQuestionPage extends StatelessWidget {
  final Map<String, dynamic> questionData;
  final String questionType;
  const SingleQuestionPage({Key? key, required this.questionData, required this.questionType,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? selectedAnswerIndex = questionData['selected_ans_index'] ?? 0;
    int correctAnswerIndex = questionData['correct_ans_index'] ?? 0 ;
    
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
        padding: const EdgeInsets.fromLTRB(50, 70, 50, 10),
        child:


        Column(
          children: [
          Row(
            children: [
              Expanded(child:
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                // margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
                padding: EdgeInsets.all(10),
                child: Text(questionData['question'], style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              ))
            ],
          ),
            SizedBox(height: 20,),
            (questionType == 'mcq') ||  (questionType == 'mcq_img') ?
            Expanded(
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

            :  Expanded(
              child: Column(
                children :[
                AnswerCard(
                    question: "Correct Answer:    ${questionData['correctAnswer']}",
                    isSelected: true,
                    currentIndex: 0,
                    correctAnswerIndex: 0,
                    selectedAnswerIndex: 0,
                  ),
                  AnswerCard(
                    question: "Your Response:     ${questionData['enteredAnswer']}",
                    isSelected: true,
                    currentIndex: 0,
                    correctAnswerIndex: questionData['enteredAnswer'] == questionData['correctAnswer']? 0 : 1, // if the correct ans and selected ans is same then green else red
                    selectedAnswerIndex: 0,
                  ),
                ]
              ),
            )
            ,

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FlashCard(opSign: questionData["sign"] ,)));
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
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Learn  ' + questionData["sign"] + '',
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
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
