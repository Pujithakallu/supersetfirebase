import 'package:flutter/material.dart';
// import 'package:op_games/learn_section/operator.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/widgets/answer_card.dart';
// import 'package:op_games/widgets/next_button.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/question_data/mcq_question.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/question_data/gen_mcq_questions.dart';
import 'package:flutter_tts/flutter_tts.dart';
import "package:supersetfirebase/gamescreen/mathoperations/common/translate/translate.dart";
import 'package:supersetfirebase/gamescreen/mathoperations/common/global.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/result_page.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/level/level_info.dart';
import 'dart:developer';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/analytics_engine.dart';

class McqQuiz extends StatefulWidget {
  final String opSign;
  final LevelInfo level;
  const McqQuiz({Key? key, required this.opSign, required this.level})
      : super(key: key);

  @override
  State<McqQuiz> createState() => _McqQuizState();
}

class _McqQuizState extends State<McqQuiz> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  List<String> languageNames = ["English", "Spanish"];
  //late double screenWidth = MediaQuery.of(context).size.width;
  late List<McqQuestion> questions;
  FlutterTts flutterTts = FlutterTts();
  int currentLanguage = 0;
  late Map<String, dynamic> pageLangData;
  late List<String> quesHeading;
  late List<String> LangKeys;
  int score = 0;
  int correctAnswersCount = 0;
  List<Map<String, dynamic>> questionResults = [];

  @override
  void initState() {
    super.initState();
    if (widget.opSign == 'mix') {
      questions = getMixMcqQuestions(widget.opSign);
    } else {
      questions = getMcqQuestions(widget.opSign);
    }
    pageLangData =
        getMCQLanguageData(GlobalVariables.priLang, GlobalVariables.secLang);
    quesHeading = [
      pageLangData["ques_heading"]["pri_lang"],
      pageLangData["ques_heading"]["sec_lang"]
    ];
    LangKeys = [
      getSpeakLangKey(GlobalVariables.priLang),
      getSpeakLangKey(GlobalVariables.secLang)
    ];

    questionResults = List.generate(
        questions.length,
        (_) => {
              "question": "",
              "options": [],
              "selected_ans_index": -1, // -1 means no answer selected
              "is_right": false,
              "sign": ""
            });
  }

  void changeLang() async {
    setState(() {
      currentLanguage = currentLanguage == 0 ? 1 : 0;
    });
    print('Button clicked');
    String newLanguage = languageNames[currentLanguage];
    await AnalyticsEngine.logTranslateButtonClickQuiz(newLanguage);
    print('Language changed to: $newLanguage');
  }

  Future<void> ReadOut(String text) async {
    await flutterTts.setLanguage(LangKeys[currentLanguage]);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = questions[questionIndex];

    questionResults[questionIndex] = {
      "question": question.question[0],
      "options": question.options,
      "selected_ans_index": selectedAnswerIndex,
      "correct_ans_index": question.correctAnswerIndex,
      "is_right": selectedAnswerIndex == question.correctAnswerIndex,
      "sign": question.sign
    };
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score += 10;
      correctAnswersCount++;
    }
    setState(() {});
  }

  void gotoNextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    double screenWidth = MediaQuery.of(context).size.width;
    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;
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
                automaticallyImplyLeading:
                    false, // Prevents default back button
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

              // Logout Button (Styled as FloatingActionButton)
              Positioned(
                right: 16,
                top: 12,
                child: FloatingActionButton(
                  heroTag: "logoutButton",
                  onPressed: () => logout(context),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  mini: true, // Smaller button
                  child: const Icon(Icons.logout_rounded, size: 32),
                ),
              ),
            ],
          ),
        ),
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
                            fontSize: (screenWidth / 25).clamp(16.0, 28.0),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          question.question[currentLanguage],
                          style: TextStyle(
                            fontSize: (screenWidth / 25).clamp(16.0, 28.0),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: selectedAnswerIndex == null
                          ? () => pickAnswer(index)
                          : null,
                      child: AnswerCard(
                        currentIndex: index,
                        question: question.options[index][currentLanguage],
                        isSelected: selectedAnswerIndex == index,
                        selectedAnswerIndex: selectedAnswerIndex,
                        correctAnswerIndex: question.correctAnswerIndex,
                      ),
                    );
                  },
                ),
                // Next button
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        ReadOut(
                            '$quesHeading[currentLanguage], ${question.question}');
                        await AnalyticsEngine.logAudioButtonClick(
                            currentLanguage);
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
                    //SizedBox(width: 170,),
                    Spacer(flex: 1),
                    InkWell(
                      onTap: () {
                        //print("..Current Question Index: $questionIndex");
                        //print("..Total Questions: ${questions.length}");
                        if (questionIndex == questions.length - 1 &&
                            selectedAnswerIndex != null) {
                          // print("..Navigating to results page.");
                          widget.level.updateScore(
                              score, correctAnswersCount, questions.length);
                          log("global score: " +
                              GlobalVariables.totalScore.toString());
                          log(GlobalVariables.levels[widget.level.levelNumber]
                              .toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultsPage(
                                        correctAnswersCount:
                                            correctAnswersCount,
                                        totalQuestions: questions.length,
                                        score: score,
                                        questionResults: questionResults,
                                        questionType: "mcq",
                                      )));
                        } else if (selectedAnswerIndex != null) {
                          gotoNextQuestion();
                        }
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: screenWidth / 4,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: selectedAnswerIndex != null
                              ? Colors.lightBlue
                              : Colors.grey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      (screenWidth / 30).clamp(16.0, 30.0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //SizedBox(width: 170,),
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
                              style: TextStyle(
                                  fontSize: screenWidth / 60,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
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
        ));
  }
}
