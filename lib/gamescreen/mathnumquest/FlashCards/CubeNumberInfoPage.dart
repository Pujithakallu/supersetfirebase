import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import "package:google_fonts/google_fonts.dart";
import '../analytics_engine.dart';

class CubesExamplePage extends StatefulWidget {
  const CubesExamplePage({super.key});

  @override
  _CubesExamplePageState createState() => _CubesExamplePageState();
}

class _CubesExamplePageState extends State<CubesExamplePage> {
  bool _isEnglish = true;
  List<Map<String, String>> _examples = [];
  final String practiceType = 'cube_numbers';

  final List<Map<String, String>> _allExamples = [
    {
      'Front_en': 'What is the cube of 3 (three)?',
      'Front_es': '¿Cuál es el cubo de 3?',
      'Back_en': '27',
      'Back_es': '27',
    },
    {
      'Front_en': 'What is the cube of 5 (five)?',
      'Front_es': '¿Cuál es el cubo de 5?',
      'Back_en': '125',
      'Back_es': '125',
    },
    {
      'Front_en': 'What is the cube root of 64?',
      'Front_es': '¿Cuál es la raíz cúbica de 64?',
      'Back_en': '4',
      'Back_es': '4',
    },
    {
      'Front_en': 'True or False: 100 is a cube number.',
      'Front_es': 'Verdadero o Falso: 100 es un número cúbico.',
      'Back_en': 'False\n(No integer x satisfies x³ = 100)',
      'Back_es': 'Falso\n(Ningún número entero cumple x³ = 100)',
    },
    {
      'Front_en': 'What is the smallest two-digit cube number?',
      'Front_es': '¿Cuál es el número cúbico de dos dígitos más pequeño?',
      'Back_en': '8',
      'Back_es': '8',
    },
  ];

  @override
  void initState() {
    super.initState();
    _refreshExamples();
  }

  void _refreshExamples() {
    setState(() {
      _examples = (_allExamples.toList()..shuffle()).take(3).toList();
    });

    // Log "More Examples" button click
    AnalyticsEngine.logMoreExamplesClick(practiceType);
    print('More Examples clicked in cube Practice');
  }

  void _onCardFlip() {
    // Log card flip interaction
    AnalyticsEngine.logCardFlip(practiceType);
    print('Card flipped in cube Practice');
  }

  void _onTranslatePressed() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
    
    // Log translate button click
    String language = AnalyticsEngine.getLanguageString(_isEnglish);
    AnalyticsEngine.logTranslateButtonClickPractice(language, practiceType);
    print('Translate button clicked in cube Practice: $language');
  }

  String _numberToWords(String number) {
    Map<String, String> numberWords = {
      '0': 'zero',
      '1': 'one',
      '2': 'two',
      '3': 'three',
      '4': 'four',
      '5': 'five',
      '6': 'six',
      '7': 'seven',
      '8': 'eight',
      '9': 'nine',
      '27': 'twenty-seven',
      '64': 'sixty-four',
      '125': 'one hundred twenty-five',
      '100': 'one hundred',
    };

    return numberWords[number] != null
        ? '$number (${numberWords[number]})'
        : number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEnglish
            ? 'Cube Number Practice'
            : 'Práctica de Números Cúbicos'),
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _isEnglish
                        ? 'Tap on the card to reveal the answer'
                        : 'Toca la tarjeta para revelar la respuesta',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 38,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 3.0,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  ListView.builder(
                    itemCount: _examples.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildExampleCard(
                        _isEnglish
                            ? _examples[index]['Front_en']!
                            : _examples[index]['Front_es']!,
                        _isEnglish
                            ? _numberToWords(_examples[index]['Back_en']!)
                            : _examples[index]['Back_es']!,
                      );
                    },
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
                          _isEnglish ? 'More Examples' : 'Más ejemplos',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onTranslatePressed,
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          backgroundColor: Colors.amber.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _isEnglish
                              ? 'Tap to Translate'
                              : 'Toca para Traducir',
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
      ),
    );
  }

  Widget _buildExampleCard(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        onFlip: _onCardFlip,
        front: Container(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Text(
              question,
              style: const TextStyle(fontSize: 25, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        back: Container(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                answer,
                style: const TextStyle(fontSize: 25, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
