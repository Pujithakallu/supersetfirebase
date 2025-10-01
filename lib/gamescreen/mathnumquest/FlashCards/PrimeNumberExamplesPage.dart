import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../analytics_engine.dart';

class PrimeNumberPracticePage extends StatefulWidget {
  @override
  _PrimeNumberPracticePageState createState() =>
      _PrimeNumberPracticePageState();
}

class _PrimeNumberPracticePageState extends State<PrimeNumberPracticePage> {
  bool _isEnglish = true;
  List<Map<String, dynamic>> _examples = [];
  late FlutterTts flutterTts;
  final String practiceType = 'prime_numbers';

  final List<Map<String, dynamic>> _allExamples = [
    {
      'question_en': 'Which of the following is a prime number?',
      'question_es': '¿Cuál de los siguientes es un número primo?',
      'options': ['4 (four)', '6 (six)', '2 (two)'],
      'answer': '2 (two)',
    },
    {
      'question_en': 'Which of the following is not a prime number?',
      'question_es': '¿Cuál de los siguientes no es un número primo?',
      'options': ['2 (two)', '3 (three)', '9 (nine)'],
      'answer': '9 (nine)',
    },
    {
      'question_en': 'How many prime numbers are there between 10 and 25?',
      'question_es': '¿Cuántos números primos hay entre 10 y 25?',
      'options': ['5 (five)', '4 (four)', '3 (three)'],
      'answer': '5 (five)',
    },
    {
      'question_en':
          'Which of these is a list of prime numbers between 61 and 75?',
      'question_es':
          '¿Cuál de estas es una lista de números primos entre 61 y 75?',
      'options': ['61, 67, 71, 73', '67, 71, 73', '63, 67, 71'],
      'answer': '67, 71, 73',
    },
    {
      'question_en': 'How many prime numbers are there between 0 and 100?',
      'question_es': '¿Cuántos números primos hay entre 0 y 100?',
      'options': ['26 (twenty-six)', '24 (twenty-four)', '25 (twenty-five)'],
      'answer': '25 (twenty-five)',
    },
    {
      'question_en': 'What is the smallest prime number greater than 20?',
      'question_es': '¿Cuál es el número primo más pequeño mayor que 20?',
      'options': ['23 (twenty-three)', '19 (nineteen)', '21 (twenty-one)'],
      'answer': '23 (twenty-three)',
    },
    {
      'question_en': 'How many prime numbers are there between 50 and 60?',
      'question_es': '¿Cuántos números primos hay entre 50 y 60?',
      'options': ['2 (two)', '1 (one)', '3 (three)'],
      'answer': '1 (one)',
    },
    {
      'question_en': 'What is the sum of the first three prime numbers?',
      'question_es': '¿Cuál es la suma de los primeros tres números primos?',
      'options': ['10 (ten)', '12 (twelve)', '17 (seventeen)'],
      'answer': '17 (seventeen)',
    },
  ];

  @override
  void initState() {
    super.initState();
    _refreshExamples();
    flutterTts = FlutterTts();
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  void _refreshExamples() {
    setState(() {
      _examples = (_allExamples.toList()..shuffle()).take(3).toList();
    });
     // Log "More Examples" button click
    AnalyticsEngine.logMoreExamplesClick(practiceType);
    print('More Examples clicked in Composite Practice');
  }


  void _onTranslatePressed() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
    
    // Log translate button click
    String language = AnalyticsEngine.getLanguageString(_isEnglish);
    AnalyticsEngine.logTranslateButtonClickPractice(language, practiceType);
    print('Translate button clicked in Composite Practice: $language');
  }

  void _checkAnswer(String selectedOption, String correctAnswer) {
    bool isCorrect = selectedOption == correctAnswer;
    String message = isCorrect
        ? (_isEnglish ? 'Correct!' : '¡Correcto!')
        : (_isEnglish ? 'Try Again.' : 'Intenta de nuevo.');
    
    // Log practice answer
    AnalyticsEngine.logPracticeAnswer(practiceType, isCorrect);
    print('Practice Answer logged: ${isCorrect ? 'Correct' : 'Incorrect'}');
    speak(message); // Speak the result
    showResultDialog(context, isCorrect);
  }
  void showResultDialog(BuildContext context, bool isCorrect) {
    String message = isCorrect
        ? (_isEnglish ? 'Correct!' : '¡Correcto!')
        : (_isEnglish ? 'Try Again.' : 'Intenta de nuevo.');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            isCorrect
                ? (_isEnglish ? 'Well Done!' : '¡Bien hecho!')
                : (_isEnglish ? 'Oops!' : '¡Vaya!'),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          ),
          content: Text(message, style: const TextStyle(fontSize: 20)),
          actions: [
            TextButton(
              child: Text(
                _isEnglish ? 'OK' : 'Aceptar',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(dialogContext, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEnglish
            ? 'Prime Number Practice'
            : 'Práctica de Números Primos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Log game completion with final score
            AnalyticsEngine.logGameCompleteInMiddle();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/MathNumQuest/background1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _isEnglish
                      ? 'Select the correct answer'
                      : 'Selecciona la respuesta correcta',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 38,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: const Offset(5.0, 5.0),
                          blurRadius: 3.0,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: _examples.length,
                    itemBuilder: (context, index) {
                      return _buildQuestionCard(
                        _examples[index]['question_en']!,
                        _examples[index]['options'],
                        _examples[index]['answer']!,
                        _examples[index]['question_es']!,
                        _examples[index]['options'],
                        _examples[index]['answer']!,
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _refreshExamples,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: Colors.lightBlueAccent.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        _isEnglish ? 'More Examples' : 'Más ejemplos',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onTranslatePressed,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: Colors.amber.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        _isEnglish ? 'Tap to Translate' : 'Toca para Traducir',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
    String questionEn,
    List<String> options,
    String answer,
    String questionEs,
    List<String> optionsEs,
    String answerEs,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isEnglish ? questionEn : questionEs,
                style: const TextStyle(fontSize: 25, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: options.map((option) {
                  return ElevatedButton(
                    onPressed: () {
                     // speak(option); // Speak option when tapped
                      _checkAnswer(option, answer);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: Colors.yellow.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
