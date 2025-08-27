import 'package:flutter/material.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/widgets/answer_card.dart';
// import 'package:op_games/widgets/next_button.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/question_data/mcq_img_question.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/question_data/gen_mcq_img_questions.dart';
import 'package:flutter_tts/flutter_tts.dart';
import "package:supersetfirebase/gamescreen/mathoperations/common/translate/translate.dart";
import 'package:supersetfirebase/gamescreen/mathoperations/common/global.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/result_page.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/level/level_info.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/analytics_engine.dart';

class McqImgQuiz extends StatefulWidget {
  final String opSign;
  final LevelInfo level;
  const McqImgQuiz({super.key, required this.opSign, required this.level});

  @override
  State<McqImgQuiz> createState() => _McqImgQuizState();
}

class _McqImgQuizState extends State<McqImgQuiz> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  List<String> languageNames = ["English", "Spanish"];
  late List<McqImgQuestion> questions;
  FlutterTts flutterTts = FlutterTts();
  int currentLanguage = 0;
  late Map<String, dynamic> pageLangData;
  late List<String> quesHeading;
  late List<String> imgName;
  late List<String> LangKeys;
  int score = 0;
  int correctAnswersCount = 0;
  List<Map<String, dynamic>> questionResults = [];

  @override
  void initState() {
    super.initState();
    if (widget.opSign == 'mix') {
      questions = getMixMcqImgQuestions(widget.opSign);
    } else {
      questions = getMcqImgQuestions(widget.opSign);
    }
    pageLangData = getMcqImgLanguageData(
        GlobalVariables.priLang, GlobalVariables.secLang, widget.opSign);
    quesHeading = [
      pageLangData["ques_heading"]["pri_lang"],
      pageLangData["ques_heading"]["sec_lang"]
    ];
    imgName = [
      pageLangData["img_name"]["pri_lang"],
      pageLangData["img_name"]["sec_lang"]
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
      score += 2;
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
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        //height: (screenWidth / 8).clamp(120.0, 150.0),
                        width: screenWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              quesHeading[currentLanguage],
                              style: TextStyle(
                                // backgroundColor: Colors.grey,
                                fontSize: (screenWidth / 25).clamp(16.0, 28.0),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            OrangesDisplay(
                              firstSetOfOranges: question.firstNum,
                              secondSetOfOranges: question.secNum,
                              sign: question.sign,
                            ),
                            // Text(
                            //   question.question[currentLanguage],
                            //   style: const TextStyle(
                            //     // backgroundColor: Colors.grey,
                            //     fontSize: 40,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
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
                                '${quesHeading[currentLanguage]}, ${question.firstNum} ${imgName[currentLanguage]} ${question.sign} '
                                '${question.secNum} ${imgName[currentLanguage]}');
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
                        // SizedBox(width: screenWidth/5,),
                        Spacer(flex: 1),
                        InkWell(
                          onTap: () {
                            //print("..Current Question Index: $questionIndex");
                            //print("..Total Questions: ${questions.length}");
                            if (questionIndex == questions.length - 1 &&
                                selectedAnswerIndex != null) {
                              // print("..Navigating to results page.");
                              widget.level.updateScore(score);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultsPage(
                                            correctAnswersCount:
                                                correctAnswersCount,
                                            totalQuestions: questions.length,
                                            score: score,
                                            questionResults: questionResults,
                                            questionType: "mcq_img",
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(width: screenWidth/5,),
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
                                Icon(
                                  Icons.translate,
                                  size: screenWidth / 40,
                                ),
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
        ));
  }
}

class OrangesWithNumber extends StatelessWidget {
  final int count;

  const OrangesWithNumber({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          //chageto row
          alignment: WrapAlignment.center, //delete
          children: List.generate(
            count,
            (index) => _OrangeWithSpacing(),
          ),
        ),
        // SizedBox(height: 10),
        // Container(
        //   padding: EdgeInsets.all(6),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     border: Border.all(color: Colors.black, width: 6),
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child: Text(
        //     count.toString(),
        //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //   ),
        // ),
      ],
    );
  }
}

class OrangesDisplay extends StatelessWidget {
  final int firstSetOfOranges;
  final int secondSetOfOranges;
  final String sign;

  const OrangesDisplay({
    super.key,
    required this.firstSetOfOranges,
    required this.secondSetOfOranges,
    required this.sign,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrangesWithNumber(count: firstSetOfOranges),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            sign,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        OrangesWithNumber(count: secondSetOfOranges),
      ],
    );
  }
}

class _Orange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(8), // Adjust padding as needed
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the box
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(
        'assets/Mathoperations/orange.png',
        width: screenWidth / 60,
        height: screenWidth / 40,
      ),
    );
  }
}

class _OrangeWithSpacing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: _Orange(),
    );
  }
}
