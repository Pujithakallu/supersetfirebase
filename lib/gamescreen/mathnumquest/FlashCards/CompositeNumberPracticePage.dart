import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../analytics_engine.dart'; // Import analytics engine

class CompositeNumberPracticePage extends StatefulWidget {
  CompositeNumberPracticePage({super.key});

  @override
  _CompositeNumberPracticePageState createState() =>
      _CompositeNumberPracticePageState();
}

class _CompositeNumberPracticePageState
    extends State<CompositeNumberPracticePage> {
  bool _isEnglish = true;
  late FlutterTts flutterTts;
  List<Map<String, dynamic>> _examples = [];
  final String practiceType = 'composite_numbers'; // Define practice type

  final List<Map<String, dynamic>> _allExamples = [
    {
      'question_en': 'Which of the following is a composite number?',
      'question_es': 'Â¿CuÃ¡l de los siguientes es un nÃºmero compuesto?',
      'options': ['7', '11', '15'],
      'answer': '15',
    },
    {
      'question_en': 'Which number is not a composite number?',
      'question_es': ' Â¿QuÃ© nÃºmero no es un nÃºmero compuesto?',
      'options': ['4', '13', '12'],
      'answer': '13',
    },
    {
      'question_en':
          'What are the factors of the composite number 18 (eighteen)?',
      'question_es': 'Â¿CuÃ¡les son los factores del nÃºmero compuesto 18 ?',
      'options': ['1,18', '2,3,6,9', '1,2,3,6,9,18'],
      'answer': '1,2,3,6,9,18',
    },
    {
      'question_en':
          'Which of the following numbers has more than two factors?',
      'question_es':
          'Â¿CuÃ¡l de los siguientes nÃºmeros tiene mÃ¡s de dos factores?',
      'options': ['24', '19', '13'],
      'answer': '24',
    },
    {
      'question_en':
          'Which of these numbers is a composite number because it has factors other than 1 and itself?',
      'question_es':
          'Â¿CuÃ¡l de estos nÃºmeros es un nÃºmero compuesto porque tiene factores diferentes de 1 y de sÃ­ mismo?',
      'options': ['6', '7', '5'],
      'answer': '6',
    },
    {
      'question_en':
          'Identify the composite number that is a product of 2 and 5:',
      'question_es': 'Identifica el nÃºmero compuesto que es producto de 2 y 5:',
      'options': ['15', '10', '25'],
      'answer': '10',
    },
    {
      'question_en': 'Which of the following is the smallest composite number?',
      'question_es':
          'Â¿CuÃ¡l de los siguientes es el nÃºmero compuesto mÃ¡s pequeÃ±o?',
      'options': ['2', '1', '4'],
      'answer': '4',
    },
    {
      'question_en':
          'Which number is composite because it can be factored into smaller prime numbers?',
      'question_es':
          'Â¿QuÃ© nÃºmero es compuesto porque se puede factorizar en nÃºmeros primos mÃ¡s pequeÃ±os?',
      'options': ['57', '51', '49'],
      'answer': '57',
    },
  ];

  String _numberToWords(String number) {
    switch (number) {
      case '1':
        return 'one';
      case '2':
        return 'two';
      case '3':
        return 'three';
      case '4':
        return 'four';
      case '5':
        return 'five';
      case '6':
        return 'six';
      case '7':
        return 'seven';
      case '8':
        return 'eight';
      case '9':
        return 'nine';
      case '10':
        return 'ten';
      case '11':
        return 'eleven';
      case '12':
        return 'twelve';
      case '13':
        return 'thirteen';
      case '15':
        return 'fifteen';
      case '18':
        return 'eighteen';
      case '19':
        return 'nineteen';
      case '24':
        return 'twenty-four';
      case '57':
        return 'fifty-seven';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _refreshExamples();
  }

  void _refreshExamples() {
    setState(() {
      _examples = (_allExamples.toList()..shuffle()).take(3).toList();
    });
    
    // Log "More Examples" button click
    AnalyticsEngine.logMoreExamplesClick(practiceType);
    print('More Examples clicked in Composite Practice');
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  void _checkAnswer(String selected, String correctAnswer) {
    bool isCorrect = selected == correctAnswer;
    String message = isCorrect
        ? (_isEnglish ? 'Correct!' : 'Â¡Correcto!')
        : (_isEnglish ? 'Try Again.' : 'Intenta de nuevo.');

    // Log practice answer
    AnalyticsEngine.logPracticeAnswer(practiceType, isCorrect);
    print('Practice Answer logged: ${isCorrect ? 'Correct' : 'Incorrect'}');

    speak(message); // Speak result
    showResultDialog(context, isCorrect);
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
        ? (_isEnglish ? 'Correct!' : 'Â¡Correcto!')
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
                ? (_isEnglish ? 'Well Done!' : 'Â¡Bien hecho!')
                : (_isEnglish ? 'Oops!' : 'Â¡Vaya!'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEnglish
            ? 'Composite Number Practice'
            : 'PrÃ¡ctica de NÃºmeros compuesto'),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        backgroundColor: Colors.lightBlueAccent.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        _isEnglish ? 'More Examples' : 'MÃ¡s ejemplos',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onTranslatePressed,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                  final optionWithText = '$option (${_numberToWords(option)})';
                  return ElevatedButton(
                    onPressed: () {
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
                      optionWithText,
                      style: TextStyle(fontSize: 20, color: Colors.black87),
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