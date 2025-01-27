// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:op_games/quiz_section/result_page.dart';
// import 'dart:math';
// import 'package:number_to_words_english/number_to_words_english.dart';
// import 'package:op_games/common/question_data/mcq_question.dart';
// import 'package:op_games/common/question_data/gen_mcq_questions.dart';
//
// enum Language { English, Spanish }
// enum Operation { Addition, Subtraction, Multiplication, Division, Mix }
//
// class McqQuiz extends StatefulWidget {
//   final String opSign;
//
//   const McqQuiz({Key? key, required this.opSign}) : super(key: key);
//
//   @override
//   State<McqQuiz> createState() => _McqQuizState();
// }
//
// class _McqQuizState extends State<McqQuiz> {
//   int currentQuestionIndex = 0;
//   Language selectedLanguage = Language.English;
//   late FlutterTts flutterTts;
//   bool questionAnswered = false;
//   String? selectedOption;
//   late List<Question> questions;
//
//   int score = 0;
//   int correctAnswersCount = 0;
//   List<Map<String, dynamic>> questionResults = [];
//
//   @override
//   void initState() {
//     super.initState();
//     flutterTts = FlutterTts();
//     questions = generateRandomQuestions(5); // For example, generate 5 random questions at initialization
//     questionResults = List.generate(questions.length, (_) => {
//       "question": "",
//       "options": [],
//       "selected_ans_index": -1, // -1 means no answer selected
//       "is_right": false,
//       "sign": ""
//     });
//   }
//
//   List<Question> generateRandomQuestions(int count) {
//     List<Question> generatedQuestions = [];
//     Random random = Random();
//
//     for (int i = 0; i < count; i++) {
//       Operation operation;
//       String questionText;
//       int firstNumber;
//       int secondNumber;
//       int result;
//
//       switch (widget.opSign) {
//         case '+':
//           operation = Operation.Addition;
//           questionText = "How many oranges are there in total?";
//           firstNumber = random.nextInt(5) + 1;
//           secondNumber = random.nextInt(5) + 1;
//           result = firstNumber + secondNumber;
//           break;
//         case '-':
//           operation = Operation.Subtraction;
//           questionText = "How many oranges are left?";
//           firstNumber = random.nextInt(5) + 1;
//           secondNumber = random.nextInt(firstNumber) + 1;
//           result = firstNumber - secondNumber;
//           break;
//         case 'x':
//           operation = Operation.Multiplication;
//           questionText = "How many oranges are there in total?";
//           firstNumber = random.nextInt(5) + 1;
//           secondNumber = random.nextInt(5) + 1;
//           result = firstNumber * secondNumber;
//           break;
//         case '÷':
//           operation = Operation.Division;
//           questionText = "How many oranges are there in total?";
//           firstNumber = (random.nextInt(5) + 1) * (random.nextInt(5) + 1);
//           secondNumber = random.nextInt(5) + 1;
//           result = firstNumber ~/ secondNumber;
//           break;
//         case 'mix':
//         default:
//           operation = Operation.Mix;
//           questionText = "How many oranges are there in total?";
//           firstNumber = random.nextInt(5) + 1;
//           secondNumber = random.nextInt(5) + 1;
//           result = firstNumber + secondNumber;
//           break;
//       }
//
//       Set<int> optionsSet = {result};
//       while (optionsSet.length < 4) {
//         optionsSet.add(random.nextInt(25) + 1);
//       }
//       List<String> options = optionsSet.map((e) => e.toString()).toList();
//       options.shuffle();
//
//       generatedQuestions.add(Question(
//         questionText: questionText,
//         options: options,
//         correctAnswer: result.toString(),
//         numberOfOranges: result,
//         orangeSets: [firstNumber, secondNumber],
//         operation: operation,
//       ));
//     }
//
//     return generatedQuestions;
//   }
//
//   Future<void> speakQuestion(String text) async {
//     await flutterTts.setLanguage(selectedLanguage == Language.English ? 'en-US' : 'es-ES');
//     await flutterTts.setSpeechRate(0.35);
//     await flutterTts.speak(text);
//   }
//
//   void checkAnswer(String selectedAnswer) {
//     bool isCorrect = selectedAnswer == questions[currentQuestionIndex].correctAnswer;
//
//     setState(() {
//       selectedOption = selectedAnswer;
//       questionAnswered = true;
//     });
//
//     final question = questions[currentQuestionIndex];
//     questionResults[currentQuestionIndex] = {
//       "question": question.questionText,
//       "options": question.options,
//       "selected_ans_index": questions[currentQuestionIndex].options.indexOf(selectedAnswer),
//       "correct_ans_index": questions[currentQuestionIndex].options.indexOf(question.correctAnswer),
//       "is_right": isCorrect,
//       "sign": widget.opSign
//     };
//
//     if (isCorrect) {
//       score += 2;
//       correctAnswersCount++;
//     }
//
//     Future.delayed(Duration(seconds: 8), () {
//       if (mounted && selectedOption != null) { // Check if the widget is still mounted and an answer was selected
//         if (currentQuestionIndex < questions.length - 1) {
//           setState(() {
//             currentQuestionIndex++;
//             questionAnswered = false;
//             selectedOption = null;
//           });
//         } else {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ResultsPage(
//                 correctAnswersCount: correctAnswersCount,
//                 totalQuestions: questions.length,
//                 score: score,
//                 questionResults: questionResults,
//               ),
//             ),
//           );
//         }
//       }
//     });
//   }
//
//   void gotoNextQuestion() {
//     if (currentQuestionIndex < questions.length - 1) {
//       setState(() {
//         currentQuestionIndex++;
//         questionAnswered = false;
//         selectedOption = null;
//       });
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ResultsPage(
//             correctAnswersCount: correctAnswersCount,
//             totalQuestions: questions.length,
//             score: score,
//             questionResults: questionResults,
//           ),
//         ),
//       );
//     }
//   }
//
//   void toggleLanguage() {
//     setState(() {
//       selectedLanguage = selectedLanguage == Language.English ? Language.Spanish : Language.English;
//     });
//   }
//
//   String getQuestionText() {
//     String questionText = questions[currentQuestionIndex].questionText;
//     if (selectedLanguage == Language.Spanish) {
//       questionText = questionText.replaceAll('How many oranges are there in total?', '¿Cuántas naranjas hay en total?')
//           .replaceAll('How many oranges are left?', '¿Cuántas naranjas quedan?');
//     }
//     return questionText;
//   }
//
//   String getOptionText(String option) {
//     try {
//       final int number = int.parse(option);
//       String inWords = NumberToWordsEnglish.convert(number);
//       return inWords;
//     } catch (e) {
//       return option;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Question currentQuestion = questions[currentQuestionIndex];
//
//     double screenWidth = MediaQuery.of(context).size.width;
//     double buttonWidth = screenWidth * 0.8;
//     double maxButtonWidth = 800.0;
//     buttonWidth = buttonWidth > maxButtonWidth ? maxButtonWidth : buttonWidth;
//
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.pop(context),
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white38,
//         shape: CircleBorder(),
//         child: const Icon(Icons.arrow_back_ios),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.white54, Colors.black54],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               OrangesDisplay(
//                 firstSetOfOranges: currentQuestion.orangeSets[0],
//                 secondSetOfOranges: currentQuestion.orangeSets[1],
//                 operation: currentQuestion.operation,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 getQuestionText(),
//                 style: TextStyle(color: Colors.black87, fontSize: 36, fontWeight: FontWeight.w900),
//               ),
//               SizedBox(height: 20),
//               Column(
//                 children: questions[currentQuestionIndex].options.map((option) {
//                   return Container(
//                     width: buttonWidth,
//                     margin: EdgeInsets.only(bottom: 8),
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.black, width: 2),
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: ElevatedButton(
//                       onPressed: !questionAnswered ? () => checkAnswer(option) : null,
//                       child: Text(
//                         getOptionText(option),
//                         style: TextStyle(
//                           color: Colors.black87,
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                               (states) {
//                             if (!questionAnswered) return Colors.transparent;
//                             if (option == selectedOption && option != questions[currentQuestionIndex].correctAnswer) return Colors.redAccent;
//                             if (option == questions[currentQuestionIndex].correctAnswer) return Colors.greenAccent;
//                             return Colors.transparent;
//                           },
//                         ),
//                         shadowColor: MaterialStateProperty.all(Colors.transparent),
//                         elevation: MaterialStateProperty.all(0),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               if (questionAnswered && currentQuestionIndex < questions.length - 1)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: ElevatedButton(
//                     onPressed: gotoNextQuestion,
//                     child: Text('Next', style: TextStyle(fontSize: 20)),
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
//                   ),
//                 ),
//               if (questionAnswered && currentQuestionIndex == questions.length - 1)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultsPage(
//                         correctAnswersCount: correctAnswersCount,
//                         totalQuestions: questions.length,
//                         score: score,
//                         questionResults: questionResults,
//                       )));
//                     },
//                     child: Text('Finish', style: TextStyle(fontSize: 20)),
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
//                   ),
//                 ),
//               SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 80, // Increase the width as needed
//                     height: 80, // Increase the height as needed
//                     child: FloatingActionButton(
//                       onPressed: () => speakQuestion(getQuestionText()),
//                       child: Icon(Icons.volume_up, size: 40), // Increase the icon size as needed
//                       backgroundColor: Colors.white38,
//                     ),
//                   ),
//                   SizedBox(width: 20),
//                   SizedBox(
//                     width: 80, // Increase the width as needed
//                     height: 80, // Increase the height as needed
//                     child: FloatingActionButton(
//                       onPressed: toggleLanguage,
//                       child: Icon(Icons.g_translate, size: 40), // Increase the icon size as needed
//                       backgroundColor: Colors.white38,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Question {
//   final String questionText;
//   final List<String> options;
//   final String correctAnswer;
//   final int numberOfOranges;
//   final List<int> orangeSets;
//   final Operation operation;
//
//   Question({
//     required this.questionText,
//     required this.options,
//     required this.correctAnswer,
//     required this.numberOfOranges,
//     required this.orangeSets,
//     required this.operation,
//   });
// }
//
// class OrangesDisplay extends StatelessWidget {
//   final int firstSetOfOranges;
//   final int secondSetOfOranges;
//   final Operation operation;
//
//   const OrangesDisplay({
//     Key? key,
//     required this.firstSetOfOranges,
//     required this.secondSetOfOranges,
//     required this.operation,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         OrangesWithNumber(count: firstSetOfOranges),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Text(
//             operation == Operation.Addition ? '+' : operation == Operation.Subtraction ? '-' : operation == Operation.Multiplication ? 'x' : '÷',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//         ),
//         OrangesWithNumber(count: secondSetOfOranges),
//       ],
//     );
//   }
// }
//
// class OrangesWithNumber extends StatelessWidget {
//   final int count;
//
//   const OrangesWithNumber({Key? key, required this.count}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: List.generate(
//             count,
//                 (index) => _OrangeWithSpacing(),
//           ),
//         ),
//         SizedBox(height: 10),
//         Container(
//           padding: EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.black, width: 6),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             count.toString(),
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _Orange extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8), // Adjust padding as needed
//       decoration: BoxDecoration(
//         color: Colors.white, // Background color for the box
//         border: Border.all(color: Colors.black, width: 2),
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Image.asset(
//         'assets/Mathoperations/orange.png',
//         width: 60,
//         height: 60,
//       ),
//     );
//   }
// }
//
// class _OrangeWithSpacing extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: _Orange(),
//     );
//   }
// }