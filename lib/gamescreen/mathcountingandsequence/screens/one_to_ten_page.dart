import 'package:supersetfirebase/gamescreen/mathcountingandsequence/analytics_engine.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../utils/number_generator.dart';
import '../widgets/number_option_button.dart';
import '../widgets/non_clickable_number.dart';
import 'right_answer.dart';
import 'wrong_answer.dart';

class OneToTenPage extends StatefulWidget {
  final int initialScore;

  const OneToTenPage({super.key, this.initialScore = 0});

  @override
  _OneToTenPageState createState() => _OneToTenPageState();
}

class _OneToTenPageState extends State<OneToTenPage> {
  bool showSpanish = false;
  List<String> sequence = [];
  String correctOption = '';
  List<String> options = [];
  late int score;
  final player = AudioPlayer();
  final audioCache = AudioCache(prefix: 'assets/MathC&S/');

  void playSound(String soundPath) async {
    await player.play(AssetSource(soundPath));
  }

  @override
  void initState() {
    super.initState();
    score = widget.initialScore; // Initialize score from the widget's property
    generateSequence();
  }

  void generateSequence() {
    sequence = NumberGenerator.generateSequence(4);
    correctOption = NumberGenerator.generateCorrectOption(sequence);
    options = NumberGenerator.generateOptions(sequence);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[100],
        appBar: AppBar(
          title: const Text('LEVEL 1'),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'assets/MathC&S/p5.gif', // Ensure your image path is correct
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (String number in sequence)
                      NonClickableNumber(
                          text: showSpanish
                              ? NumberGenerator.convertToSpanish(number)
                              : number),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Choose an Option',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                for (String option in options)
                  NumberOptionButton(
                    text: showSpanish
                        ? NumberGenerator.convertToSpanish(option)
                        : option,
                    onPressed: () {
                      if (option == correctOption) {
                        playSound('MathC&S/audio/game-correct.mp3');

                        setState(() {
                          score += 10; // Add points for a correct answer
                        });
                        navigate(context, true);
                      } else {
                        playSound('MathC&S/audio/game-wrong.mp3');

                        setState(() {
                          score -= 5; // Subtract points for a wrong answer
                        });
                        navigate(context, false);
                      }
                    },
                  ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showSpanish = !showSpanish;
                    });
                    final selectedLang = showSpanish ? 'Spanish' : 'English';
                    AnalyticsEngine.logLanguageToggle(selectedLang);
                  },
                  child: Text(
                    showSpanish ? 'English' : 'Español',
                    style: const TextStyle(fontSize: 23),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  void navigate(BuildContext context, bool isCorrect) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isCorrect
            ? RightAnswerPage(
                score: score,
                onNextQuestionPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OneToTenPage(initialScore: score)));
                })
            : WrongAnswerPage(score: score),
      ),
    );
  }
}
