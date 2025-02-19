import 'package:flutter/material.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/question_data/gen_text_questions.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/question_data/text_question.dart';
// import 'package:op_games/common/widgets/next_button.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:developer';
import "package:supersetfirebase/gamescreen/mathoperations/common/translate/translate.dart";
import 'package:supersetfirebase/gamescreen/mathoperations/common/global.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/result_page.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/level/level_info.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class TextQuiz extends StatefulWidget {
  final String opSign;
  final LevelInfo level;
  const TextQuiz({super.key, required this.opSign, required this.level});

  @override
  State<TextQuiz> createState() => _TextQuizState();
}

class _TextQuizState extends State<TextQuiz> {
  String? selectedAnswer;
  int questionIndex = 0;
  bool? isCorrect;
  bool isAnswerSubmitted = false;
  int submissionAttempts = 0;
  String feedbackMessage = '';
  FlutterTts flutterTts = FlutterTts();
  int currentLanguage = 0;
  late Map<String, dynamic> pageLangData;
  late List<String> quesHeading;
  late List<String> hintText;
  late List<String> popUpText;
  late List<String> LangKeys;
  int score = 0;
  int correctAnswersCount = 0;
  List<Map<String, dynamic>> questionResults = [];

  TextEditingController textEditingController = TextEditingController();
  late List<TextQuestion> questions;
  @override
  void initState() {
    super.initState();
    if (widget.opSign == 'mix') {
      questions = getMixTextQuestions(widget.opSign);
    } else {
      questions = getTextQuestions(widget.opSign);
    }
    pageLangData =
        getTextLanguageData(GlobalVariables.priLang, GlobalVariables.secLang);
    quesHeading = [
      pageLangData["ques_heading"]["pri_lang"],
      pageLangData["ques_heading"]["sec_lang"]
    ];
    hintText = [
      pageLangData["hint_text"]["pri_lang"],
      pageLangData["hint_text"]["sec_lang"]
    ];
    popUpText = [
      pageLangData["pop_up_heading"]["pri_lang"],
      pageLangData["pop_up_heading"]["sec_lang"]
    ];
    LangKeys = [
      getSpeakLangKey(GlobalVariables.priLang),
      getSpeakLangKey(GlobalVariables.secLang)
    ];
  }

  void changeLang() {
    setState(() {
      currentLanguage = currentLanguage == 0 ? 1 : 0;
    });
  }

  Future<void> ReadOut(String text) async {
    await flutterTts.setLanguage(LangKeys[currentLanguage]);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  void pickAnswer(String value) {
    selectedAnswer = value;
    setState(() {
      isCorrect = null; // Reset correctness feedback
      isAnswerSubmitted = false; // Reset answer submitted status
    });
  }

  void submitAnswer() {
    if (isAnswerSubmitted) {
      return;
    }
    final currQuestion = questions[questionIndex];
    bool correct =
        selectedAnswer?.toLowerCase() == currQuestion.answer.toLowerCase() ||
            selectedAnswer?.toLowerCase() ==
                currQuestion.answer.replaceAll("-", "").toLowerCase();
    if (correct) {
      setState(() {
        isCorrect = true;
        isAnswerSubmitted = true; // Set answer submitted status to true
        score += 2;
        correctAnswersCount++;
      });
    } else {
      setState(() {
        isCorrect = false;
        //submissionAttempts++;
        isAnswerSubmitted = true;
        // if (submissionAttempts >= 3) {
        //   isAnswerSubmitted = true; // Set answer submitted status to true
        // }
      });
    }
    questionResults.add({
      'question': currQuestion.question[currentLanguage],
      'correctAnswer': currQuestion.answer,
      'enteredAnswer': selectedAnswer,
      'is_right': correct,
      'sign': widget.opSign
    });
  }

  void gotoNextQuestion() {
    if (selectedAnswer == null && !isAnswerSubmitted) {
      // Show a SnackBar if no answer is submitted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(popUpText[currentLanguage]),
        ),
      );
      return;
    } // Exit the function early
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswer = null; // Clear current answer
      isCorrect = null; // Reset correctness feedback
      isAnswerSubmitted = false; // Reset answer submitted status
      textEditingController.clear(); // Clear text field
    } else {
      widget.level.updateScore(score);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultsPage(
                    correctAnswersCount: correctAnswersCount,
                    totalQuestions: questions.length,
                    score: score,
                    questionResults: questionResults,
                    questionType: "text",
                  )));
    }
    setState(() {});
  }

  void gotoPreviousQuestion() {
    if (questionIndex > 0) {
      questionIndex--;
      selectedAnswer = null; // Clear current answer
      isCorrect = null; // Reset correctness feedback
      isAnswerSubmitted = false; // Reset answer submitted status
      textEditingController.clear(); // Clear text field
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final quizquestion = questions[questionIndex];
    // log('data: $questions');
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    bool isLastQuestion = questionIndex == questions.length - 1;
    bool isFirstQuestion = questionIndex == 0;
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
            image: AssetImage('assets/Mathoperations/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth / 10, screenWidth / 20,
              screenWidth / 10, screenWidth / 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: (screenWidth / 8).clamp(120.0, 120.0),
                width: screenWidth,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quesHeading[currentLanguage],
                      style: TextStyle(
                        fontSize: (screenWidth / 25).clamp(16.0, 30.0),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      quizquestion.question[currentLanguage],
                      style: TextStyle(
                        fontSize: (screenWidth / 25).clamp(16.0, 30.0),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              TextField(
                controller: textEditingController,
                onChanged: (value) {
                  pickAnswer(value);
                },
                style: TextStyle(
                  fontSize: screenWidth / 50, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
                decoration: InputDecoration(
                  hintText: hintText[
                      currentLanguage], // need to change the hintText according to the user selected language,
                  border: OutlineInputBorder(),
                  filled: true, // Enable filling of the background
                  fillColor: isCorrect == null
                      ? Colors.white54
                      : isCorrect == true
                          ? Colors.green
                          : Colors
                              .red, // Set background color based on correctness
                  errorBorder: OutlineInputBorder(
                    // Border color when there is an error
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    // Border color when there is an error and the field is focused
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      ReadOut(
                          '${quesHeading[currentLanguage]} ${quizquestion.question[currentLanguage]}');
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: screenWidth / 10,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.volume_up,
                            size: screenWidth / 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(width: 170),
                  Spacer(flex: 1),
                  InkWell(
                    onTap: selectedAnswer != null && !isAnswerSubmitted
                        ? submitAnswer
                        : null,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: screenWidth / 4,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: selectedAnswer != null && !isAnswerSubmitted
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //SizedBox(width: 180),
                  Spacer(flex: 1),
                  InkWell(
                    onTap: () {
                      if (!isLastQuestion ||
                          isAnswerSubmitted ||
                          selectedAnswer != null) {
                        gotoNextQuestion();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: screenWidth / 4,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:
                            isAnswerSubmitted ? Colors.lightBlue : Colors.grey,
                      ),
                      child: Center(
                        child: Text(
                          isLastQuestion ? 'Finish' : 'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //SizedBox(width: 180),
                  Spacer(flex: 1),
                  InkWell(
                    onTap: () {
                      changeLang();
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: screenWidth / 10,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            currentLanguage == 0 ? 'Español' : 'English',
                            style: TextStyle(fontSize: screenWidth / 60, color: Colors.black, fontWeight: FontWeight.bold),
                        )
                          // Icon(
                          //   Icons.translate,
                          //   size: screenWidth / 40,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
