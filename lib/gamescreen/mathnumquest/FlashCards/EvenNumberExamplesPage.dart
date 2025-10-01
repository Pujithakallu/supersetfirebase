import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import "package:google_fonts/google_fonts.dart";
import '../analytics_engine.dart';

class EvenNumberExamplesPage extends StatefulWidget {
  const EvenNumberExamplesPage({super.key});

  @override
  _EvenNumberExamplesPageState createState() {
    return _EvenNumberExamplesPageState();
  }
}

class _EvenNumberExamplesPageState extends State<EvenNumberExamplesPage> {
  bool _isEnglish = true; // State to keep track of language
  List<Map<String, String>> _examples = [];
  final String practiceType = 'even_odd_numbers'; // Correct practice type for even/odd numbers

  // Map to hold numbers and their corresponding English words
  final Map<String, String> numberWords = {
    '2': 'two',
    '4': 'four',
    '6': 'six',
    '8': 'eight',
    '10': 'ten',
    '12': 'twelve',
    '14': 'fourteen',
    '16': 'sixteen',
    '18': 'eighteen',
    '20': 'twenty',
    '75': 'seventy-five',
    '45': 'forty-five',
    '9': 'nine',
    '15': 'fifteen',
    '55': 'fifty-five',
    '31': 'thirty-one',
  };

  final List<Map<String, String>> _allExamples = [
    {
      'number': '2',
      'description_en':
          'It\'s EVEN! \nThere are 2 sides to a coin: heads and tails!',
      'description_es': '¡Es PAR! \n¡Hay 2 lados en una moneda: cara y cruz!',
    },
    {
      'number': '4',
      'description_en': 'It\'s EVEN! \nFour wheels on a car make it even!',
      'description_es': '¡Es PAR! \n¡Cuatro ruedas en un coche lo hacen par!',
    },
    {
      'number': '6',
      'description_en': 'It\'s EVEN! \nSix legs on three insects, all even!',
      'description_es': '¡Es PAR! \n¡Seis patas en tres insectos, todo par!',
    },
    //... more numbers
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
    print('More Examples clicked in Even/Odd Practice');
  }

  void _onCardFlip() {
    // Log card flip interaction
    AnalyticsEngine.logCardFlip(practiceType);
    print('Card flipped in Even/Odd Practice');
  }

  void _onTranslatePressed() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
    
    // Log translate button click
    String language = AnalyticsEngine.getLanguageString(_isEnglish);
    AnalyticsEngine.logTranslateButtonClickPractice(language, practiceType);
    print('Translate button clicked in Even/Odd Practice: $language');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEnglish
            ? 'Odd-Even Number Practice'
            : 'Ejemplos de Números Primos'),
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
                  const SizedBox(height: 30),

                  // ListView inside scrollable column
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _examples.length,
                    itemBuilder: (context, index) {
                      final number = _examples[index]['number']!;
                      final description = _isEnglish
                          ? _examples[index]['description_en']!
                          : _examples[index]['description_es']!;
                      return _buildExampleCard(number, description);
                    },
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _refreshExamples,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: Colors.lightBlueAccent.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _isEnglish ? 'More Examples' : 'Más ejemplos',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
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
                          _isEnglish ? 'Tap to Translate' : 'Toca para Traducir',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
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

  Widget _buildExampleCard(String number, String description) {
    String numberText = numberWords[number] != null
        ? '$number (${numberWords[number]})'
        : number;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        onFlip: _onCardFlip, // Log card flip interaction
        front: Container(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Text(
              numberText, // Display number with text
              style: const TextStyle(fontSize: 50, color: Colors.black54),
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
                description,
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