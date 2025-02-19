import 'package:flutter/material.dart';
import 'analytics_engine.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class PartsOfEquations extends StatefulWidget {
  @override
  _PartsOfEquationsState createState() => _PartsOfEquationsState();
}

class _PartsOfEquationsState extends State<PartsOfEquations> {
  bool showAnswer = false;
  String selectedAnswer = '';
  bool isSpanish = false;

  final Map<String, String> englishText = {
    'title': 'Parts of Equations',
    'coefficient':
        '1. Coefficient: A numerical or constant quantity placed before and multiplying the variable in an algebraic expression (e.g., 4 in 4x).',
    'variable':
        '2. Variable: A symbol for a number we don’t know yet. It is usually a letter like x or y.',
    'operator':
        '3. Operator: Symbols that represent operations (e.g., +, -, *, /).',
    'constant':
        '4. Constant: A fixed value. In the equation 2x + 3 = 5, 3 and 5 are constants.',
    'quizTitle': 'Quiz:',
    'quizQuestion': 'What is the variable in the equation x + 2 = 5?',
    'correctAnswer': 'Correct! x is the variable.',
    'incorrectAnswer': 'Incorrect. x is the variable.',
  };

  final Map<String, String> spanishText = {
    'title': 'Partes de las Ecuaciones',
    'coefficient':
        '1. Coeficiente: Una cantidad numérica o constante colocada antes y multiplicando la variable en una expresión algebraica (por ejemplo, 4 en 4x).',
    'variable':
        '2. Variable: Un símbolo para un número que aún no conocemos. Por lo general, es una letra como x o y.',
    'operator':
        '3. Operador: Símbolos que representan operaciones (por ejemplo, +, -, *, /).',
    'constant':
        '4. Constante: Un valor fijo. En la ecuación 2x + 3 = 5, 3 y 5 son constantes.',
    'quizTitle': 'Cuestionario:',
    'quizQuestion': '¿Cuál es la variable en la ecuación x + 2 = 5?',
    'correctAnswer': '¡Correcto! x es la variable.',
    'incorrectAnswer': 'Incorrecto. x es la variable.',
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
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Adjust horizontal padding as needed
            child: IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: Color(0xFF6C63FF),
                size: 26,
              ),
              onPressed: () => logout(context),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 16.0),
            child: IntrinsicWidth(
              child: Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text['title']!,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        text['coefficient']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        text['variable']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        text['operator']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        text['constant']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          'assets/Mathequations/PartsOfEquation.png',
                          height: 300,
                          width: MediaQuery.of(context).size.width * 0.8,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              text['quizTitle']!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              text['quizQuestion']!,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => checkAnswer('x'),
                              style: ButtonStyle(
                                backgroundColor: selectedAnswer == 'x'
                                    ? MaterialStateProperty.all(Colors.green)
                                    : null,
                              ),
                              child: const Text('x'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () => checkAnswer('2'),
                              style: ButtonStyle(
                                backgroundColor: selectedAnswer == '2'
                                    ? MaterialStateProperty.all(Colors.red)
                                    : null,
                              ),
                              child: const Text('2'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () => checkAnswer('5'),
                              style: ButtonStyle(
                                backgroundColor: selectedAnswer == '5'
                                    ? MaterialStateProperty.all(Colors.red)
                                    : null,
                              ),
                              child: const Text('5'),
                            ),
                          ],
                        ),
                      ),
                      if (showAnswer)
                        Center(
                          child: Text(
                            selectedAnswer == 'x'
                                ? text['correctAnswer']!
                                : text['incorrectAnswer']!,
                            style: TextStyle(
                              fontSize: 18,
                              color: selectedAnswer == 'x'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
