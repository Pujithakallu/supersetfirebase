import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';
import 'shapes_data.dart';
import 'theme_state.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class GenericQuizPage extends StatefulWidget {
  final String shapeName;
  const GenericQuizPage({Key? key, required this.shapeName}) : super(key: key);

  @override
  _GenericQuizPageState createState() => _GenericQuizPageState();
}

class _GenericQuizPageState extends State<GenericQuizPage> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late List<Map<String, dynamic>> _questions;
  int currentQuestionIndex = 0;
  int attemptsLeft = 2;
  String? selectedOption;
  int score = 0;

  final FlutterTts flutterTts = FlutterTts();
  bool _isSpeaking = false;

  bool _isEnglish = true;

  Map<String, dynamic> get shapeData =>
      shapes.firstWhere((element) => element['name'] == widget.shapeName);

  Color _getThemeColor(bool isDark) {
    return isDark ? shapeData['darkcolor'] : shapeData['color'];
  }

  @override
  void initState() {
    super.initState();
    _questions = List<Map<String, dynamic>>.from(shapeData['quiz']['questions']);
    _setupTTS();
  }

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
    _setupTTS();
    //_updatePageContent();
  }

  Future<void> _setupTTS() async {
    await flutterTts.setLanguage(_isEnglish ? 'en-US' : 'es-ES');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speakCurrentQuestion() async {
    await flutterTts.stop();
    final question = _questions[currentQuestionIndex];
    String toSpeak = _isEnglish
      ? question['question']['en']
      : question['question']['es'];

    List<String> options = List<String>.from(
      question['options'][_isEnglish ? 'en' : 'es']);

    for (var option in options) {
      toSpeak += ". $option";
    }

    setState(() {
    _isSpeaking = true;
    
  });

    await flutterTts.setLanguage(_isEnglish ? 'en-US' : 'es-ES');
    await flutterTts.speak(toSpeak);

    flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop(); // Ensures narration stops on leaving the page
    super.dispose();
  }

  void showHint(bool isDark) {
    final hint = _questions[currentQuestionIndex]['hint'][_isEnglish ? 'en' : 'es'] ?? '';
    if (hint.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: isDark ? const Color(0xFF171717) : null,
            title: Text(_isEnglish ? 'Hint' : 'Pista', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
            content: Text(hint, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
            actions: [
              TextButton(
                style: TextButton.styleFrom(foregroundColor: isDark ? Colors.white : Colors.black),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void checkAnswer(bool isDark) {
    if (selectedOption != null &&
        selectedOption == _questions[currentQuestionIndex]['correctAnswer'][_isEnglish ? 'en' : 'es']) {
      setState(() {
        score += 5;
      });
      nextQuestion();
    } else {
      setState(() {
        score -= 1;
        attemptsLeft--;
      });

      if (attemptsLeft <= 0) {
        final correctAnswer = _questions[currentQuestionIndex]['correctAnswer'][_isEnglish ? 'en' : 'es'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: isDark ? const Color(0xFF171717) : null,
            title: Text('Incorrect', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
            content: Text(
              'You have used all attempts.\nThe correct answer is:\n\n$correctAnswer',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(foregroundColor: isDark ? Colors.white : Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                  nextQuestion();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: isDark ? const Color(0xFF171717) : null,
            title: Text('Incorrect', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
            content: Text(
              'Try again. You have $attemptsLeft attempt${attemptsLeft == 1 ? '' : 's'} left.',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(foregroundColor: isDark ? Colors.white : Colors.black),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  //void nextQuestion() {
  Future<void> nextQuestion() async {
  await flutterTts.stop(); // Stop any ongoing speech
  setState(() {
    _isSpeaking = false; // Reset the speaking flag
  });

    if (currentQuestionIndex < _questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        attemptsLeft = 2;
        selectedOption = null;
      });
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  Widget _buildFinalScoreCard(bool isDark) {
    final double maxCardWidth = min(MediaQuery.of(context).size.width * 0.9, 600);
    final double maxCardHeight = min(MediaQuery.of(context).size.height * 0.9, 650);
    final bool isPerfectScore = score == (_questions.length * 5);

    return Center(
      child: Container(
        width: maxCardWidth,
        height: maxCardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Card(
          elevation: 8.0,
          color: isDark ? const Color(0xFF171717) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  isPerfectScore
                      ? 'assets/Mathgeometry/full-marks.gif'
                      : 'assets/Mathgeometry/party-pop.gif',
                  height: isPerfectScore ? 100 : 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Quiz Completed!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Your Score: $score/${_questions.length * 5}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        analytics.logEvent(name: '${widget.shapeName} Quiz Restart');
                        setState(() {
                          score = 0;
                          currentQuestionIndex = 0;
                          selectedOption = null;
                          attemptsLeft = 2;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getThemeColor(isDark),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      child: const Text(
                        'Restart Quiz',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      child: const Text(
                        'Exit',
                        style: TextStyle(fontSize: 16.0),
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeModel,
      builder: (context, _) {
        bool isDark = themeModel.isDarkMode;
        final Color themeColor = _getThemeColor(isDark);
        final media = MediaQuery.of(context);

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(67.2),
            child: Container(
              color: themeColor,
              child: SafeArea(
                child: Container(
                  height: 67.2,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            '${widget.shapeName} Quiz',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                '+5: Correct',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                ),
                              ),
                              Text(
                                '-1: Wrong',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            width: 1.5,
                            height: 34.0,
                            color: Colors.white,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Score: $score',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),

                          IconButton(
                          icon: const Icon(Icons.translate, color: Colors.white),
                          onPressed: _toggleLanguage,
                          ),
                          
                          IconButton(
                          onPressed: () async {
                            analytics.logEvent(name: '${widget.shapeName} Quiz Sound');
                            if (_isSpeaking) {
                              await flutterTts.stop();
                              setState(() {
                                _isSpeaking = false;
                            });
                          } else {
                            await _speakCurrentQuestion();
                          }
                        },
                        icon: Icon(
                          Icons.volume_up,
                          color: _isSpeaking ? Colors.blue : Colors.white,
                        ),
                      ),

                      IconButton(
                            icon: Icon(
                              isDark ? Icons.nightlight_round : Icons.wb_sunny,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              themeModel.toggleTheme();
                            },
                          ),

                      ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    key: ValueKey(isDark),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          isDark
                              ? 'assets/Mathgeometry/practice-dark.gif'
                              : 'assets/Mathgeometry/practice.gif',
                        ),
                        fit: BoxFit.cover,
                        alignment: const Alignment(0, 0.3),
                      ),
                    ),
                  ),
                ),
              ),
              currentQuestionIndex >= _questions.length
                  ? _buildFinalScoreCard(isDark)
                  : Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 600,
                          maxHeight: media.size.height * 0.85,
                        ),
                        child: Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          color: isDark ? const Color(0xFF171717) : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final currentQuestion = _questions[currentQuestionIndex];
                                return SingleChildScrollView(
                                  physics: constraints.maxHeight < 600
                                      ? const BouncingScrollPhysics()
                                      : const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (currentQuestion['questionImage'] != '')
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 16.0),
                                          child: Image.asset(
                                            currentQuestion['questionImage'],
                                            height: constraints.maxHeight * 0.38,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      Text(
                                        currentQuestion['question'][_isEnglish ? 'en' : 'es'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? Colors.white : themeColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 16.0),
                                      ...List<Widget>.from(
                                        (currentQuestion['options'][_isEnglish ? 'en' : 'es'] as List).map(
                                          (option) => RadioListTile<String>(
                                            title: Text(
                                              option,
                                              style: TextStyle(color: isDark ? Colors.white : themeColor),
                                            ),
                                            value: option,
                                            groupValue: selectedOption,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedOption = value;
                                              });
                                            },
                                            activeColor: themeColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      TextButton(
                                        onPressed: () => showHint(isDark),
                                        child: Text(
                                          _isEnglish ? 'Hint' : 'Pista',
                                          style: TextStyle(color: isDark ? Colors.white : themeColor),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      ElevatedButton(
                                        onPressed: () => checkAnswer(isDark),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: themeColor,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Text(_isEnglish? 'Submit': 'Entregar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
