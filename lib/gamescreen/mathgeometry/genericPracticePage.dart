import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';
import 'shapes_data.dart';
import 'theme_state.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class GenericPracticePage extends StatefulWidget {
  final String shapeName;
  const GenericPracticePage({super.key, required this.shapeName});

  @override
  _GenericPracticePageState createState() => _GenericPracticePageState();
}

class _GenericPracticePageState extends State<GenericPracticePage>
    with TickerProviderStateMixin {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  int _score = 0;
  int _questionIndex = 0;
  late List<Map<String, dynamic>> _questions;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  final FlutterTts flutterTts = FlutterTts();
  bool _isSpeaking = false;

  bool _isEnglish = true;

  // Retrieve shape data so we can use shape['color'] and shape['darkcolor'].
  Map<String, dynamic> get shapeData =>
      shapes.firstWhere((element) => element['name'] == widget.shapeName);
  Map<String, dynamic> get practiceData => shapeData['practice'];

  // Returns the shape's button color according to mode.
  Color _getShapeButtonColor(bool isDark) {
    final Color shapeColor = shapeData['color'];
    final Color shapeDarkColor = shapeData['darkcolor'];
    return isDark ? shapeDarkColor : shapeColor;
  }

  @override
  void initState() {
    super.initState();
    _questions =
        List<Map<String, dynamic>>.from(practiceData['questions'] as List);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _setupTTS();
  }

    void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
    //_updatePageContent();
  }

  Future<void> _setupTTS() async {
    await flutterTts.setLanguage(_isEnglish ? 'en-US' : 'es-ES');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speakCurrentQuestion() async {
    await flutterTts.stop();
    final question = _questions[_questionIndex];
    String toSpeak = _isEnglish
      ? question['question']['en']
      : question['question']['es'];
    
    for (var answer in question['answers']) {
      final text = _isEnglish ? answer['text']['en'] : answer['text']['es'];
      toSpeak += ". $text";
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
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _answerQuestion(bool isCorrect) async {
    await flutterTts.stop();
    setState(() {
      _isSpeaking = false;
    });

    if (isCorrect) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      _questionIndex++;
      _isFlipped = false;
    });
  }

  void _resetQuiz() {
    analytics.logEvent(name: '${widget.shapeName} Practice Restart');
    setState(() {
      _score = 0;
      _questionIndex = 0;
      _isFlipped = false;
      _controller.reset();
    });
  }

  void _flipCard() {
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isFlipped = !_isFlipped;
  }

  /// Builds the flip card for questions.
  Widget _buildFlipCard(bool isDark) {
    final double maxCardWidth = min(MediaQuery.of(context).size.width * 0.9, 600);
    final double maxCardHeight = min(MediaQuery.of(context).size.height * 0.9, 650);

    return Container(
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
        child: _isFlipped
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(pi),
                child: _buildAnswerCard(isDark),
              )
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(0),
                child: _buildQuestionCard(isDark),
              ),
      ),
    );
  }

  /// Builds the question side of the flip card.
  Widget _buildQuestionCard(bool isDark) {
    final currentQuestion = _questions[_questionIndex];
    return LayoutBuilder(
      builder: (context, constraints) {
        final double horizontalPad = constraints.maxWidth * 0.05;
        final double topPad = constraints.maxHeight * 0.10;
        final double bottomPad = constraints.maxHeight * 0.05;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.fromLTRB(horizontalPad, topPad, horizontalPad, bottomPad),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top content: image, question text, answer buttons.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (currentQuestion['questionImage'] != '')
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Image.asset(
                            currentQuestion['questionImage'],
                            height: 300.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          currentQuestion['question'][_isEnglish ? 'en' : 'es'],
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (currentQuestion['answers'] as List).length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
                        itemBuilder: (context, index) {
                          final answer = (currentQuestion['answers'] as List)[index];
                          return ElevatedButton(
                            onPressed: () => _answerQuestion(answer['correct']),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _getShapeButtonColor(isDark),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            child: Text(
                              answer['text'][_isEnglish ? 'en' : 'es'],
                              style: const TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  // Flip button pinned at bottom center.
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: IconButton(
                      onPressed: _flipCard,
                      icon: const Icon(Icons.flip),
                      color: isDark ? Colors.white : Colors.black,
                      style: IconButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the answer side of the flip card.
  Widget _buildAnswerCard(bool isDark) {
    final currentQuestion = _questions[_questionIndex];
    final answers = currentQuestion['answers'] as List;
    final correctAnswer =
        answers.firstWhere((answer) => answer['correct'] == true)['text'][_isEnglish ? 'en' : 'es'];

    return LayoutBuilder(
      builder: (context, constraints) {
        final double horizontalPad = constraints.maxWidth * 0.05;
        final double topPad = constraints.maxHeight * 0.10;
        final double bottomPad = constraints.maxHeight * 0.05;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.fromLTRB(horizontalPad, topPad, horizontalPad, bottomPad),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (currentQuestion.containsKey('answerImage') &&
                          currentQuestion['answerImage'] != '')
                        Image.asset(
                          currentQuestion['answerImage'],
                          width: 250,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                      const SizedBox(height: 20.0),
                      Text(
                        _isEnglish ? 'Correct Answer:' : 'Respuesta correcta:',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        correctAnswer,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  // Flip button pinned at bottom center.
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: IconButton(
                      onPressed: _flipCard,
                      icon: const Icon(Icons.flip),
                      color: isDark ? Colors.white : Colors.black,
                      style: IconButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the final completion screen without a card or transformation.
 Widget _buildCompletionScreen(bool isDark) {
  final double maxCardWidth = min(MediaQuery.of(context).size.width * 0.9, 600);
  final double maxCardHeight = min(MediaQuery.of(context).size.height * 0.9, 650);

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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Mathgeometry/party-pop.gif',
                    height: 200,
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
                    'Your Score: $_score/${_questions.length}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _resetQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getShapeButtonColor(isDark),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Restart Quiz',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Color _getShapeCardColor(bool isDark) {
    final Color shapeColor = shapeData['color'];
    final Color shapeDarkColor = shapeData['darkcolor'];
    return isDark ? shapeDarkColor : shapeColor;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeModel,
      builder: (context, _) {
        bool isDark = themeModel.isDarkMode;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(67.2),
            child: Container(
              color: _getShapeCardColor(themeModel.isDarkMode),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Practice: ${widget.shapeName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.translate, color: Colors.white),
                          onPressed: _toggleLanguage,
                        ),


                        IconButton(
                          onPressed: () async {
                            analytics.logEvent(name: '${widget.shapeName} Practice Sound');
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
                            themeModel.isDarkMode
                                ? Icons.nightlight_round
                                : Icons.wb_sunny,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            themeModel.toggleTheme();
                            analytics.logEvent(name: 'TC ${widget.shapeName} Practice');
                          },
                      ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Background with GIF, shifted down by 10%
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
              // Main content: if quiz is not complete, show the flip card with animation; otherwise, show final screen.
              Container(
                width: double.infinity,
                height: double.infinity,
                child: _questionIndex < _questions.length
                    ? LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: constraints.maxHeight),
                              child: Center(
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(_animation.value * pi),
                                      alignment: Alignment.center,
                                      child: _buildFlipCard(isDark),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : _buildCompletionScreen(isDark),
              ),
            ],
          ),
        );
      },
    );
  }
}
