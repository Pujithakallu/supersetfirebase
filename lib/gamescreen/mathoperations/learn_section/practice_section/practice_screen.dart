import 'package:flutter/material.dart';
// import 'package:op_games/learn_section/operator.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/widgets/answer_card.dart';
// import 'package:op_games/widgets/next_button.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/question_data/mcq_question.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/question_data/gen_mcq_questions.dart';
import 'package:flutter_tts/flutter_tts.dart';
import "package:supersetfirebase/gamescreen/mathoperations/common/translate/translate.dart";
import 'package:supersetfirebase/gamescreen/mathoperations/common/global.dart';
import 'dart:developer';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/analytics_engine.dart';

class PracticeScreen extends StatefulWidget {
  final String opSign;
  const PracticeScreen({Key? key, required this.opSign}) : super(key: key);

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  //late double screenWidth = MediaQuery.of(context).size.width;
  late List<McqQuestion> questions;
  FlutterTts flutterTts = FlutterTts();
  List<String> languageNames = ["English", "Spanish"];
  int currentLanguage = 0;
  late Map<String, dynamic> pageLangData;
  late List<String> quesHeading;
  late List<String> LangKeys;

  @override
  void initState() {
    super.initState();
    questions = getMcqQuestions(widget.opSign);
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
    log("$quesHeading");
  }

  Future<void> ReadOut(String text) async {
    await flutterTts.setLanguage(LangKeys[currentLanguage]);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {}
    setState(() {});
  }

  void changeLang() async {
    setState(() {
      currentLanguage = currentLanguage == 0 ? 1 : 0;
    });
    print('Button clicked');
    String newLanguage = languageNames[currentLanguage];
    await AnalyticsEngine.logTranslateButtonClickLearn(newLanguage);
    print('Language changed to: $newLanguage');
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
                          // backgroundColor: Colors.grey,
                          fontSize: (screenWidth / 25).clamp(16.0, 28.0),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        question.question[currentLanguage],
                        style: TextStyle(
                          // backgroundColor: Colors.grey,
                          fontSize: (screenWidth / 25).clamp(16.0, 28.0),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

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
                        if (questionIndex == questions.length - 1 &&
                            selectedAnswerIndex != null) {
                          Navigator.pop(context);
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
