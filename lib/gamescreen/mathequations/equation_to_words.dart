import 'package:confetti/confetti.dart';
import 'package:supersetfirebase/gamescreen/mathequations/analytics_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'instructions_widget.dart';
import 'score_manager.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class EquationToWordsScreen extends StatefulWidget {
  const EquationToWordsScreen({Key? key}) : super(key: key);

  @override
  State<EquationToWordsScreen> createState() => _EquationToWordsScreenState();
}

class _EquationToWordsScreenState extends State<EquationToWordsScreen> {
  List<DraggableItem> draggableItems = [];

  final Map<String, Map<String, String>> translations = {
    'en': {
      'check_answers': 'Check Answers',
      'next_question': 'Next Question',
      'game_over': 'Game Over',
      'congratulations': 'Congratulations! Your final score is ',
      'play_again': 'Play Again',
      'correct': 'Correct! Well done',
      'incorrect': 'Incorrect. Try again.',
      'drop_items': 'Drop items here',
      'instructions':
          'Welcome to Parts of Equations!\n\nLearn and play with equations.\n\nDrag the part of the equation to the correct answer. Once you finish dragging all the parts into the correct boxes, click "Check Answers" button.\n',
    },
    'es': {
      'check_answers': 'Verificar respuestas',
      'next_question': 'Siguiente pregunta',
      'game_over': 'Fin del juego',
      'congratulations': '¡Felicidades! Tu puntaje final es ',
      'play_again': 'Jugar de nuevo',
      'correct': '¡Correcto! Bien hecho',
      'incorrect': 'Incorrecto. Inténtalo de nuevo.',
      'drop_items': 'Suelta los elementos aquí',
      'instructions':
          '¡Bienvenido a "Ecuaciones a Palabras"!\n\nAprende y juega con las ecuaciones.\n\nArrastra y suelta las palabras dadas en el orden correcto para que coincidan con cómo se lee una ecuación en voz alta.\n',
    }
  };

  final List<Map<String, dynamic>> easyQuestions = [
    {
      'equation': '2x + 4 = 8',
      'words': ['x', 'four', 'times', 'equals', 'two', 'eight', 'plus'],
      'translated': ['x', 'cuatro', 'veces', 'igual', 'dos', 'ocho', 'más'],
      'answer': ['two', 'times', 'x', 'plus', 'four', 'equals', 'eight'],
      'translatedAnswer': [
        'dos',
        'veces',
        'x',
        'más',
        'cuatro',
        'igual',
        'ocho'
      ],
    },
    {
      'equation': '3y - 5 = 10',
      'words': ['y', 'three', 'minus', 'equals', 'five', 'ten'],
      'translated': ['y', 'tres', 'menos', 'igual', 'cinco', 'diez'],
      'answer': ['three', 'y', 'minus', 'five', 'equals', 'ten'],
      'translatedAnswer': ['tres', 'y', 'menos', 'cinco', 'igual', 'diez'],
    },
    {
      'equation': '4a + 7 = 19',
      'words': ['a', 'four', 'plus', 'equals', 'seven', 'nineteen'],
      'translated': ['a', 'cuatro', 'más', 'igual', 'siete', 'diecinueve'],
      'answer': ['four', 'a', 'plus', 'seven', 'equals', 'nineteen'],
      'translatedAnswer': [
        'cuatro',
        'a',
        'más',
        'siete',
        'igual',
        'diecinueve'
      ],
    },
    {
      'equation': '5b - 2 = 13',
      'words': ['b', 'five', 'minus', 'equals', 'two', 'thirteen'],
      'translated': ['b', 'cinco', 'menos', 'igual', 'dos', 'trece'],
      'answer': ['five', 'b', 'minus', 'two', 'equals', 'thirteen'],
      'translatedAnswer': ['cinco', 'b', 'menos', 'dos', 'igual', 'trece'],
    },
    {
      'equation': '6c + 3 = 21',
      'words': ['c', 'six', 'plus', 'equals', 'three', 'twenty-one'],
      'translated': ['c', 'seis', 'más', 'igual', 'tres', 'veintiuno'],
      'answer': ['six', 'c', 'plus', 'three', 'equals', 'twenty-one'],
      'translatedAnswer': ['seis', 'c', 'más', 'tres', 'igual', 'veintiuno'],
    },
  ];

  final List<Map<String, dynamic>> mediumQuestions = [
    {
      'equation': '7d - 4 = 17',
      'words': ['d', 'seven', 'minus', 'equals', 'four', 'seventeen'],
      'translated': ['d', 'siete', 'menos', 'igual', 'cuatro', 'diecisiete'],
      'answer': ['seven', 'd', 'minus', 'four', 'equals', 'seventeen'],
      'translatedAnswer': [
        'siete',
        'd',
        'menos',
        'cuatro',
        'igual',
        'diecisiete'
      ],
    },
    {
      'equation': '8e + 2 = 18',
      'words': ['e', 'eight', 'plus', 'equals', 'two', 'eighteen'],
      'translated': ['e', 'ocho', 'más', 'igual', 'dos', 'dieciocho'],
      'answer': ['eight', 'e', 'plus', 'two', 'equals', 'eighteen'],
      'translatedAnswer': ['ocho', 'e', 'más', 'dos', 'igual', 'dieciocho'],
    },
    {
      'equation': '2x + 3y = 14',
      'words': ['x', 'y', 'two', 'three', 'plus', 'equals', 'fourteen'],
      'translated': ['x', 'y', 'dos', 'tres', 'más', 'igual', 'catorce'],
      'answer': ['two', 'x', 'plus', 'three', 'y', 'equals', 'fourteen'],
      'translatedAnswer': ['dos', 'x', 'más', 'tres', 'y', 'igual', 'catorce'],
    },
    {
      'equation': '4a - 5b = 12',
      'words': ['a', 'b', 'four', 'five', 'minus', 'equals', 'twelve'],
      'translated': ['a', 'b', 'cuatro', 'cinco', 'menos', 'igual', 'doce'],
      'answer': ['four', 'a', 'minus', 'five', 'b', 'equals', 'twelve'],
      'translatedAnswer': [
        'cuatro',
        'a',
        'menos',
        'cinco',
        'b',
        'igual',
        'doce'
      ],
    },
    {
      'equation': '6c + 7d = 29',
      'words': ['c', 'd', 'six', 'seven', 'plus', 'equals', 'twenty-nine'],
      'translated': ['c', 'd', 'seis', 'siete', 'más', 'igual', 'veintinueve'],
      'answer': ['six', 'c', 'plus', 'seven', 'd', 'equals', 'twenty-nine'],
      'translatedAnswer': [
        'seis',
        'c',
        'más',
        'siete',
        'd',
        'igual',
        'veintinueve'
      ],
    },
  ];

  final List<Map<String, dynamic>> hardQuestions = [
    {
      'equation': '5x + 4y - 3z = 10',
      'words': [
        'x',
        'y',
        'z',
        'five',
        'four',
        'three',
        'plus',
        'minus',
        'equals',
        'ten'
      ],
      'translated': [
        'x',
        'y',
        'z',
        'cinco',
        'cuatro',
        'tres',
        'más',
        'menos',
        'igual',
        'diez'
      ],
      'answer': [
        'five',
        'x',
        'plus',
        'four',
        'y',
        'minus',
        'three',
        'z',
        'equals',
        'ten'
      ],
      'translatedAnswer': [
        'cinco',
        'x',
        'más',
        'cuatro',
        'y',
        'menos',
        'tres',
        'z',
        'igual',
        'diez'
      ],
    },
    {
      'equation': '7p + 2q - r = 15',
      'words': [
        'p',
        'q',
        'r',
        'seven',
        'two',
        'one',
        'plus',
        'minus',
        'equals',
        'fifteen'
      ],
      'translated': [
        'p',
        'q',
        'r',
        'siete',
        'dos',
        'uno',
        'más',
        'menos',
        'igual',
        'quince'
      ],
      'answer': [
        'seven',
        'p',
        'plus',
        'two',
        'q',
        'minus',
        'one',
        'r',
        'equals',
        'fifteen'
      ],
      'translatedAnswer': [
        'siete',
        'p',
        'más',
        'dos',
        'q',
        'menos',
        'uno',
        'r',
        'igual',
        'quince'
      ],
    },
    {
      'equation': '3m - 2n + 4o = 9',
      'words': [
        'm',
        'n',
        'o',
        'three',
        'two',
        'four',
        'plus',
        'minus',
        'equals',
        'nine'
      ],
      'translated': [
        'm',
        'n',
        'o',
        'tres',
        'dos',
        'cuatro',
        'más',
        'menos',
        'igual',
        'nueve'
      ],
      'answer': [
        'three',
        'm',
        'minus',
        'two',
        'n',
        'plus',
        'four',
        'o',
        'equals',
        'nine'
      ],
      'translatedAnswer': [
        'tres',
        'm',
        'menos',
        'dos',
        'n',
        'más',
        'cuatro',
        'o',
        'igual',
        'nueve'
      ],
    },
    {
      'equation': '9k + 3l - 6m = 18',
      'words': [
        'k',
        'l',
        'm',
        'nine',
        'three',
        'six',
        'plus',
        'minus',
        'equals',
        'eighteen'
      ],
      'translated': [
        'k',
        'l',
        'm',
        'nueve',
        'tres',
        'seis',
        'más',
        'menos',
        'igual',
        'dieciocho'
      ],
      'answer': [
        'nine',
        'k',
        'plus',
        'three',
        'l',
        'minus',
        'six',
        'm',
        'equals',
        'eighteen'
      ],
      'translatedAnswer': [
        'nueve',
        'k',
        'más',
        'tres',
        'l',
        'menos',
        'seis',
        'm',
        'igual',
        'dieciocho'
      ],
    },
    {
      'equation': '4a + 5b - 2c = 20',
      'words': [
        'a',
        'b',
        'c',
        'four',
        'five',
        'two',
        'plus',
        'minus',
        'equals',
        'twenty'
      ],
      'translated': [
        'a',
        'b',
        'c',
        'cuatro',
        'cinco',
        'dos',
        'más',
        'menos',
        'igual',
        'veinte'
      ],
      'answer': [
        'four',
        'a',
        'plus',
        'five',
        'b',
        'minus',
        'two',
        'c',
        'equals',
        'twenty'
      ],
      'translatedAnswer': [
        'cuatro',
        'a',
        'más',
        'cinco',
        'b',
        'menos',
        'dos',
        'c',
        'igual',
        'veinte'
      ],
    },
  ];

  bool isSpanish = false; // Track the current language
  int currentQuestionIndex = 0;
  List<Map<String, String>> userAnswer = [];
  final ScoreManager _scoreManager = ScoreManager();
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));
  int currentLevel = 1;
  int totalQuestionsAnswered = 0;
  List<Map<String, dynamic>> currentLevelQuestions = [];

  final FlutterTts _flutterTts = FlutterTts();
  Future<void> _speak(String text) async {
    // Initialize TTS
    String language = isSpanish ? "es-ES" : "en-US";
    await _flutterTts.setLanguage(language);
    await _flutterTts.setPitch(1.0);
    var result = await _flutterTts.speak(text);
    print("TTS result: $result");
  }

  @override
  void initState() {
    super.initState();
    _loadLevelQuestions();
    _loadRandomQuestion();
  }

  void _loadLevelQuestions() {
    if (currentLevel == 1) {
      currentLevelQuestions = List.from(easyQuestions)..shuffle();
    } else if (currentLevel == 2) {
      currentLevelQuestions = List.from(mediumQuestions)..shuffle();
    } else if (currentLevel == 3) {
      currentLevelQuestions = List.from(hardQuestions)..shuffle();
    }
  }

  void _loadRandomQuestion() {
    currentQuestionIndex =
        totalQuestionsAnswered % currentLevelQuestions.length;
    userAnswer = List<Map<String, String>>.filled(
      currentLevelQuestions[currentQuestionIndex]['answer'].length,
      {'english': '', 'spanish': ''},
      growable: false,
    );
  }

  void _checkAnswer() {
    final answer = currentLevelQuestions[currentQuestionIndex]
        [isSpanish ? 'translatedAnswer' : 'answer'] as List<String>;

    // Join all the 'english' values from userAnswer
    final userJoinedEnglishAnswer = userAnswer
        .map((map) => map['english'] ?? '') // Extract 'english' values
        .join(' '); // Join them into a single string
    // Join all the 'english' values from userAnswer

    final userJoinedSpanishAnswer = userAnswer
        .map((map) => map['spanish'] ?? '') // Extract 'english' values
        .join(' '); // Join them into a single string

    final result =
        isSpanish ? userJoinedSpanishAnswer : userJoinedEnglishAnswer;

    if (result == answer.join(' ')) {
      setState(() {
        _scoreManager.incrementScore(10); // Increment score by 10
        _confettiController.play(); // Play confetti on correct answer
        totalQuestionsAnswered++;
        if (totalQuestionsAnswered % currentLevelQuestions.length == 0) {
          _showLevelCompleteDialog(); // Show level complete dialog
        } else {
          _loadRandomQuestion(); // Load next question
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          isSpanish
              ? translations['es']!['correct']!
              : translations['en']!['correct']!,
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isSpanish
                ? translations['es']!['incorrect']!
                : translations['en']!['incorrect']!,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showLevelCompleteDialog() {
    if (currentLevel >= 3) {
      _showFinalScoreDialog(); // End the game after Level 3
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Level Complete!'),
          content: Text(
              'Congratulations! You\'ve completed Level $currentLevel.\nYour score is: ${_scoreManager.score}.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Next Level'),
              onPressed: () {
                setState(() {
                  currentLevel++;
                  if (currentLevel > 3) {
                    _showFinalScoreDialog(); // End the game after Level 3
                  } else {
                    totalQuestionsAnswered = 0;
                    _loadLevelQuestions(); // Load questions for the new level
                    _loadRandomQuestion(); // Load the first question of the new level
                  }
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showFinalScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Complete!'),
          content: Text(
              'You\'ve completed all levels! Your final score is: ${_scoreManager.score}.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Restart Game'),
              onPressed: () {
                setState(() {
                  currentLevel = 1;
                  totalQuestionsAnswered = 0;
                  _scoreManager.resetScore();
                  _loadLevelQuestions();
                  _loadRandomQuestion();
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = currentLevelQuestions[currentQuestionIndex];
    final equation = currentQuestion['equation'] as String;
    final words = isSpanish
        ? currentQuestion['translated']
        : currentQuestion['words'] as List<String>;
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;

    return Scaffold(
      appBar: AppBar(
        title: Text('Equations to words - Level $currentLevel'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(
                  IconData(0xe67b,
                      fontFamily:
                          'MaterialIcons'), // Custom icon for translation
                  color: isSpanish
                      ? Colors.blue
                      : Colors.red, // Change icon color based on language
                ),
                label: Text(
                  isSpanish ? 'Español' : 'English',
                  style: TextStyle(
                    color: isSpanish
                        ? Colors.blue
                        : Colors.red, // Change text color based on language
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isSpanish = !isSpanish; // Toggle language
                  });
                  AnalyticsEngine.logTranslateButtonClickETW(
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
          InstructionsWidget(
              instructions: isSpanish
                  ? translations['es']!['instructions']!
                  : translations['en']!['instructions']!),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ScoreDisplay(score: _scoreManager.score),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Mathequations/Background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(equation,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(userAnswer.length, (index) {
                    return DropTarget(
                      index: index,
                      label: isSpanish
                          ? (userAnswer[index]['spanish']?.isNotEmpty ?? false)
                              ? userAnswer[index]['spanish']!
                              : translations['es']!['drop_items']!
                          : (userAnswer[index]['english']?.isNotEmpty ?? false)
                              ? userAnswer[index]['english']!
                              : translations['en']!['drop_items']!,
                      onAccept: (receivedItem) {
                        setState(() {
                          int wordIndex = words.indexOf(receivedItem);
                          userAnswer[index] = {
                            'english': currentQuestion['words'][wordIndex],
                            'spanish': currentQuestion['translated'][wordIndex],
                          };
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 40),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: words.map<Widget>((word) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10), // Adjust spacing here
                        child: DraggableItem(
                          label: word,
                          data: word,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _checkAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Set the background color to green
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check,
                          color: Colors
                              .white), // Add the check icon with white color
                      SizedBox(
                          width:
                              8), // Add some space between the icon and the text
                      Text(
                        isSpanish
                            ? translations['es']!['check_answers']!
                            : translations['en']!['check_answers']!,
                        style: TextStyle(
                            color: Colors.white), // Set the text color to white
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _loadRandomQuestion();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange, // Set the background color to orange
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_forward,
                          color: Colors
                              .white), // Add the arrow forward icon with white color
                      SizedBox(
                          width:
                              8), // Add some space between the icon and the text
                      Text(
                        isSpanish
                            ? translations['es']!['next_question']!
                            : translations['en']!['next_question']!,
                        style: TextStyle(
                            color: Colors.white), // Set the text color to white
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Confetti widget to celebrate correct answers
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.yellow
              ],
              numberOfParticles: 10,
              emissionFrequency: 0.1,
              gravity: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

class DraggableItem extends StatelessWidget {
  final String label;
  final String data;

  const DraggableItem({
    Key? key,
    required this.label,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: data,
      feedback: Material(
        color: Colors.transparent, // No background for feedback chip
        child: Chip(
          label: Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
          backgroundColor: Colors.blue, // Blue background while dragging
        ),
        elevation: 4.0,
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildDraggableContent(context),
      ),
      child: _buildDraggableContent(context),
    );
  }

  Widget _buildDraggableContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          SizedBox(width: 6),
          GestureDetector(
            onTap: () {
              final parentState = context
                  .findAncestorStateOfType<_EquationToWordsScreenState>();
              parentState?._speak(label);
              AnalyticsEngine.logAudioButtonClick(
                  parentState?.isSpanish ?? false, 'Equations To Words');
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.volume_up,
                size: 16, // Smaller size for a subtle look
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropTarget extends StatelessWidget {
  final int index;
  final String label;
  final Function(String) onAccept;

  const DropTarget(
      {Key? key,
      required this.index,
      required this.label,
      required this.onAccept})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAccept: (data) => true,
      onAccept: onAccept,
      builder: (context, candidateData, rejectedData) {
        bool isPlaceholder =
            label == 'Drop items here' || label == 'Suelta los elementos aquí';
        return Container(
          width: 125,
          height: 65,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isPlaceholder ? 16 : 20,
                fontWeight: isPlaceholder ? FontWeight.normal : FontWeight.bold,
                color: isPlaceholder ? Colors.grey : Colors.blue,
              ),
            ),
          )),
        );
      },
    );
  }
}

class ScoreDisplay extends StatelessWidget {
  final int score;

  const ScoreDisplay({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'Score: $score',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
