import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../analytics_engine.dart'; 

class FactorsPracticePage extends StatefulWidget {
  FactorsPracticePage({super.key});
  final FlutterTts flutterTts = FlutterTts();

  @override
  _FactorsPracticePageState createState() => _FactorsPracticePageState();
}

class _FactorsPracticePageState extends State<FactorsPracticePage> {
  bool _isEnglish = true;
  List<Map<String, dynamic>> _questions = [];
  final String practiceType = 'factors_numbers';

  final List<Map<String, dynamic>> _allQuestions = [
    {
      'question_en': 'Which of the following are factors of 18?',
      'question_es': '¿Cuáles de los siguientes son factores de 18?',
      'options': ['2', '5', '9', '12'],
      'correct': ['2', '9'],
    },
    {
      'question_en': 'Which number is a common factor of 12 and 16?',
      'question_es': '¿Qué número es un factor común de 12 y 16?',
      'options': ['2', '3', '4', '6'],
      'correct': ['2', '4'],
    },
    {
      'question_en': 'Which one is NOT a factor of 24?',
      'question_es': '¿Cuál NO es un factor de 24?',
      'options': ['1', '3', '8', '7'],
      'correct': ['7'],
    },
    {
      'question_en': 'What is the highest common factor (HCF) of 18 and 24?',
      'question_es': '¿Cuál es el mayor factor común (MFC) de 18 y 24?',
      'options': ['3', '6', '9', '12'],
      'correct': ['6'],
    },
    {
      'question_en': 'Which number has exactly two factors?',
      'question_es': '¿Qué número tiene exactamente dos factores?',
      'options': ['1', '7', '9', '10'],
      'correct': ['7'],
    },
    // New questions
    {
      'question_en': 'Which is a factor of 30?',
      'question_es': '¿Cuál es un factor de 30?',
      'options': ['5', '7', '11', '13'],
      'correct': ['5'],
    },
    {
      'question_en': 'Which number has factors 1, 2, and itself?',
      'question_es': '¿Qué número tiene como factores 1, 2 y él mismo?',
      'options': ['3', '4', '5', '6'],
      'correct': ['2', '4'], // Example: 4 → factors: 1,2,4
    },
    {
      'question_en': 'Which of these numbers is divisible by 3?',
      'question_es': '¿Cuál de estos números es divisible por 3?',
      'options': ['6', '10', '11', '15'],
      'correct': ['6', '15'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialQuestions();
  }

  void _loadInitialQuestions() {
    setState(() {
      _questions = _allQuestions.take(4).toList();
    });
  }

  void _loadMoreQuestions() {
    setState(() {
      final remaining = _allQuestions.skip(_questions.length).toList();
      if (remaining.isNotEmpty) {
        _questions.addAll(remaining.take(3));
      }
    });

    // Log "More Examples" button click
    AnalyticsEngine.logMoreExamplesClick(practiceType);
    print('More Examples clicked in Composite Practice');
  }

  void speak(String text) async {
    await widget.flutterTts.setLanguage("en-US");
    await widget.flutterTts.setPitch(1.0);
    await widget.flutterTts.speak(text);
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

  void showResultDialog(BuildContext context, bool isCorrect) {
    String message = isCorrect
        ? (_isEnglish ? 'Correct!' : '¡Correcto!')
        : (_isEnglish ? 'Try Again.' : 'Intenta de nuevo.');

    speak(message);

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
              child: Text(_isEnglish ? 'OK' : 'Aceptar',
                  style: TextStyle(fontSize: 18)),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(_isEnglish ? 'Factors Practice' : 'Práctica de Factores'),
        backgroundColor: Colors.orange,
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/MathNumQuest/background1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _isEnglish
                        ? 'Tap on the correct answer'
                        : 'Toca la respuesta correcta',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(4.0, 4.0),
                            blurRadius: 3.0,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Question Cards
                  ..._questions.map((q) {
                    return buildQuestionCard(
                      context,
                      question: _isEnglish ? q['question_en'] : q['question_es'],
                      options: q['options'],
                      correctAnswers: q['correct'],
                    );
                  }).toList(),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _loadMoreQuestions,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: Colors.lightBlueAccent.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _isEnglish ? 'More Questions' : 'Más Preguntas',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onTranslatePressed,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: Colors.amber.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _isEnglish
                              ? 'Tap to Translate'
                              : 'Toca para Traducir',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQuestionCard(
    BuildContext context, {
    required String question,
    required List<String> options,
    required List<String> correctAnswers,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade300,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    bool isCorrect = correctAnswers.contains(option);
                    showResultDialog(context, isCorrect);
                  },
                  child: Text(option, style: const TextStyle(fontSize: 18)),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
