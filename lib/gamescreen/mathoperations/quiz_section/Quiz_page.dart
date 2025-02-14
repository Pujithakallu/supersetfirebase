import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/Play_Page.dart';
import 'dart:math';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:supersetfirebase/utils/logout_util.dart';

enum Language { English, Spanish }

enum Operation { Addition, Subtraction }

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  int currentQuestionIndex = 0;
  Language selectedLanguage = Language.English;
  late FlutterTts flutterTts;
  bool isLastQuestion = false;
  bool questionAnswered = false;
  String? selectedOption;
  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    questions = generateRandomQuestions(
        5); // For example, generate 5 random questions at initialization
  }

  List<Question> generateRandomQuestions(int count) {
    List<Question> generatedQuestions = [];
    Random random = Random();

    for (int i = 0; i < count; i++) {
      Operation operation =
          random.nextBool() ? Operation.Addition : Operation.Subtraction;
      int firstNumber =
          random.nextInt(5) + 1; // Generates a number between 1 and 5
      int secondNumber =
          random.nextInt(5) + 1; // Generates a number between 1 and 5
      int result = operation == Operation.Addition
          ? firstNumber + secondNumber
          : firstNumber - secondNumber;

      Set<int> optionsSet = {result};
      while (optionsSet.length < 4) {
        optionsSet.add(random.nextInt(10) + 1);
      }
      List<String> options = optionsSet.map((e) => e.toString()).toList();

      options.shuffle();

      String questionText = operation == Operation.Addition
          ? "How many oranges are there in total?"
          : "How many oranges are left?";
      String correctAnswer = result.toString();

      generatedQuestions.add(Question(
        questionText: questionText,
        options: options,
        correctAnswer: correctAnswer,
        numberOfOranges:
            result, // This might need adjustment based on your visual representation needs
        orangeSets: [firstNumber, secondNumber],
        operation: operation,
      ));
    }

    return generatedQuestions;
  }

  Future<void> speakQuestion(String text) async {
    await flutterTts
        .setLanguage(selectedLanguage == Language.English ? 'en-US' : 'es-ES');
    await flutterTts.setSpeechRate(0.35);
    await flutterTts.speak(text);
  }

  void checkAnswer(String selectedAnswer) {
    bool isCorrect =
        selectedAnswer == questions[currentQuestionIndex].correctAnswer;

    setState(() {
      selectedOption = selectedAnswer;
      questionAnswered = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          if (isCorrect) {
            score += 10;
          } else {
            score -= 5;
          }
          currentQuestionIndex++;
          questionAnswered = false;
          selectedOption = null;
        });
      } else {
        setState(() {
          isLastQuestion = true;
          if (isCorrect) {
            score += 10;
          } else {
            score -= 5;
          }
        });
      }
    });
  }

  void toggleLanguage() {
    setState(() {
      selectedLanguage = selectedLanguage == Language.English
          ? Language.Spanish
          : Language.English;
    });
  }

  String getQuestionText() {
    // Assuming questions[currentQuestionIndex].questionText is in English
    String questionText = questions[currentQuestionIndex].questionText;

    if (selectedLanguage == Language.Spanish) {
      // Translate or replace with the Spanish text
      // Example:
      questionText = questionText
          .replaceAll('How many oranges are there in total?',
              '¿Cuántas naranjas hay en total?')
          .replaceAll(
              'How many oranges are left?', '¿Cuántas naranjas quedan?');
    }
    return questionText;
  }

  String getOptionText(String option) {
    try {
      // Attempt to parse the option to an integer.
      final int number = int.parse(option);

      // Convert the number to words.
      String inWords = NumberToWordsEnglish.convert(number);

      return inWords;
    } catch (e) {
      // If the option is not a number, return it as is.
      return option;
    }
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questions[currentQuestionIndex];

    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8;
    double maxButtonWidth = 800.0;
    buttonWidth = buttonWidth > maxButtonWidth ? maxButtonWidth : buttonWidth;

    return Scaffold(
      floatingActionButton: Stack(
        children: [
          //backbutton
          Positioned(
            left: 16,
            top: 16,
            child: FloatingActionButton(
              heroTag: "backButton",
              onPressed: () => Navigator.pop(context),
              foregroundColor: Colors.black,
              backgroundColor: Colors.lightBlue,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back_ios, size: 32),
            ),
          ),
          // Logout button
          Positioned(
            right: 30,
            top: 0,
            child: FloatingActionButton(
              heroTag: "logoutButton",
              onPressed: () => logout(context),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              child: const Icon(Icons.logout_rounded, size: 32),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // colors: [Color(0xffee9ca7), Color(0xffffdde1)],
            colors: [Colors.white54, Colors.black54],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OrangesDisplay(
                firstSetOfOranges: currentQuestion.orangeSets[0],
                secondSetOfOranges: currentQuestion.orangeSets[1],
                operation: currentQuestion.operation,
              ),
              SizedBox(height: 20),
              Text(
                getQuestionText(),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 36,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 20),
              Column(
                children: questions[currentQuestionIndex].options.map((option) {
                  return Container(
                    width:
                        buttonWidth, // Consider using MediaQuery to adjust for screen width.
                    margin: EdgeInsets.only(
                        bottom: 8), // Add some spacing between buttons
                    child: ElevatedButton(
                      onPressed:
                          !questionAnswered ? () => checkAnswer(option) : null,
                      child: Text(
                        getOptionText(
                            option), // This method should handle the conversion or fetching of the option text.
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            // Change the color based on the answer status
                            if (!questionAnswered)
                              return Colors
                                  .white54; // Default color before selection
                            if (option == selectedOption &&
                                option !=
                                    questions[currentQuestionIndex]
                                        .correctAnswer)
                              return Colors.redAccent; // Wrong answer
                            if (option ==
                                questions[currentQuestionIndex].correctAnswer)
                              return Colors.greenAccent; // Correct answer
                            return Colors
                                .white54; // Default color for unselected options
                          },
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (isLastQuestion && questionAnswered)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PlayPage())); // Use pushReplacement to prevent going back to the quiz
                    },
                    child:
                        Text('Back to Levels', style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                  ),
                ),
              SizedBox(height: 30),
              Text('Score: $score',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () => speakQuestion(getQuestionText()),
                    child: Icon(Icons.volume_up, size: 40),
                    backgroundColor: Colors.white38,
                  ),
                  SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: toggleLanguage,
                    child: Icon(Icons.g_translate, size: 40),
                    backgroundColor: Colors.white38,
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

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final int numberOfOranges;
  final List<int> orangeSets;
  final Operation operation;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.numberOfOranges,
    required this.orangeSets,
    required this.operation,
  });
}

class OrangesDisplay extends StatelessWidget {
  final int firstSetOfOranges;
  final int secondSetOfOranges;
  final Operation operation;

  const OrangesDisplay({
    Key? key,
    required this.firstSetOfOranges,
    required this.secondSetOfOranges,
    required this.operation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Oranges(count: firstSetOfOranges),
        // Displaying operation symbol
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            operation == Operation.Addition ? '+' : '-',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        _Oranges(count: secondSetOfOranges),
      ],
    );
  }
}

class _Oranges extends StatelessWidget {
  final int count;

  const _Oranges({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        count,
        (index) => _OrangeWithSpacing(),
      ),
    );
  }
}

class _Orange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        'assets/Mathoperations/orange.png',
        width: 60,
        height: 60,
      ),
    );
  }
}

class _OrangeWithSpacing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 4.0), // Adjust spacing between oranges as needed
      child: _Orange(),
    );
  }
}
