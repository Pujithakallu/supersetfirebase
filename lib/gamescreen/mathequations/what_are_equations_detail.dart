import 'package:flutter/material.dart';
import 'analytics_engine.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class WhatAreEquationsDetail extends StatefulWidget {
  const WhatAreEquationsDetail({Key? key}) : super(key: key);

  @override
  State<WhatAreEquationsDetail> createState() => _WhatAreEquationsDetailState();
}

class _WhatAreEquationsDetailState extends State<WhatAreEquationsDetail> {
  String? selectedAnswer;
  bool showAnswer = false;
  bool isSpanish = false;

  final Map<String, String> englishText = {
    'title': 'What are Equations?',
    'definition':
        'An equation is a mathematical statement that asserts the equality of two expressions. It consists of two expressions, one on each side of an equal sign (=).',
    'example': 'Example:',
    'exampleEquation': '2x + 3 = 5',
    'quiz': 'Quiz:',
    'quizQuestion':
        'In this example, 2x + 3 and 5 are expressions, and the equation states that they are equal.',
    'correctAnswer':
        'Correct! Equations consist of two expressions separated by an equal sign.',
    'incorrectAnswer':
        'Incorrect. Equations consist of two expressions separated by an equal sign.',
  };

  final Map<String, String> spanishText = {
    'title': '¿Qué son las ecuaciones?',
    'definition':
        'Una ecuación es una declaración matemática que afirma la igualdad de dos expresiones. Consiste en dos expresiones, una a cada lado de un signo igual (=).',
    'example': 'Ejemplo:',
    'exampleEquation': '2x + 3 = 5',
    'quiz': 'Cuestionario:',
    'quizQuestion':
        'En este ejemplo, 2x + 3 y 5 son expresiones, y la ecuación establece que son iguales.',
    'correctAnswer':
        '¡Correcto! Las ecuaciones consisten en dos expresiones separadas por un signo igual.',
    'incorrectAnswer':
        'Incorrecto. Las ecuaciones consisten en dos expresiones separadas por un signo igual.',
  };

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showAnswer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = isSpanish ? spanishText : englishText;
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;

    return Scaffold(
      appBar: AppBar(
        title: Text(text['title']!),
        actions: [
          TextButton.icon(
            icon: Icon(
              IconData(0xe67b,
                  fontFamily: 'MaterialIcons'), // Custom icon for translation
              color: isSpanish
                  ? Colors.blue
                  : Colors.red, // Change icon color based on language
            ),
            label: Text(
              isSpanish ? 'Español' : 'English',
              style: TextStyle(
                color: isSpanish ? Colors.blue : Colors.red,
              ),
            ),
            onPressed: () {
              setState(() {
                isSpanish = !isSpanish;
              });
              AnalyticsEngine.logTranslateButtonClickLearn(
                  isSpanish ? 'Changed to Spanish' : 'Changed to English');
            },
          ),
          Text(
            'PIN: $userPin',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: Color(0xFF6C63FF),
              size: 26,
            ),
            onPressed: () => logout(context),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 8,
          color: const Color(0xFFFEFFD2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text['title']!,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    text['definition']!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    text['example']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text['exampleEquation']!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    text['quiz']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text['quizQuestion']!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => checkAnswer('True'),
                        style: ButtonStyle(
                          backgroundColor: selectedAnswer == 'True'
                              ? MaterialStateProperty.all(Colors.green)
                              : null,
                        ),
                        child: const Text('True'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => checkAnswer('False'),
                        style: ButtonStyle(
                          backgroundColor: selectedAnswer == 'False'
                              ? MaterialStateProperty.all(Colors.red)
                              : null,
                        ),
                        child: const Text('False'),
                      ),
                    ],
                  ),
                  if (showAnswer)
                    Text(
                      selectedAnswer == 'True'
                          ? text['correctAnswer']!
                          : text['incorrectAnswer']!,
                      style: TextStyle(
                        fontSize: 18,
                        color: selectedAnswer == 'True'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
