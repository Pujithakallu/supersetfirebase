import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/utils/language_controller.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/widgets/language_toggle_button.dart';


class DemoMermaidGame extends StatefulWidget {
  const DemoMermaidGame({super.key});

  @override
  _DemoMermaidGameState createState() => _DemoMermaidGameState();
}

class _DemoMermaidGameState extends State<DemoMermaidGame> {
  late VideoPlayerController _videoController;
  late AudioPlayer _audioPlayer;
  late FlutterTts _flutterTts;
  int gridSize = 3;
  int seahorsePosition = 0;
  final int _mermaidCurrentPosition = 1;
  String question = "";
  int score = 0;
  bool isAnimating = false;
  bool isProcessingAnswer = false;
  Queue<int> ttsQueue = Queue<int>();
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    _initializeAudioPlayer();
    _initializeTTS();
    _generateRandomQuestion();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _audioPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  void _initializeVideoPlayer() {
    _videoController =
        VideoPlayerController.asset("assets/MathC&S/videos/background.mp4")
          ..initialize().then((_) {
            setState(() {
              _videoController.setVolume(0.0);
              _videoController.setLooping(true);
              _videoController.play();
            });
          }).catchError((error) {
            print("Error initializing video: $error");
          });
  }

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.play(AssetSource('MathC&S/audio/ocea.mp3')).catchError((error) {
      print("Error playing audio: $error");
    });
  }

  void _initializeTTS() {
    _flutterTts = FlutterTts();
    _flutterTts.setLanguage("en-US");
  }

  void _speak(String text) {
    _flutterTts.speak(text);
  }

  String _getOrdinal(int number) {
    if (number == 1) return "${number}st";
    if (number == 2) return "${number}nd";
    if (number == 3) return "${number}rd";
    return "${number}th";
  }

  void _generateRandomQuestion() {
    int totalShells = gridSize * gridSize;
    seahorsePosition = Random().nextInt(totalShells) + 1;
    question = "Find the ${_getOrdinal(seahorsePosition)} shell.";
    _speak(question);
  }

  void _onShellTap(int shellIndex) {
    if (isProcessingAnswer || isAnimating) return;

    setState(() {
      isProcessingAnswer = true;
    });

    if (shellIndex == seahorsePosition) {
      _showResult(true);
    } else {
      _showResult(false);
    }
  }

  void _showResult(bool isCorrect) {
    if (isCorrect) {
      score += 5;
      _speak("Congratulations! You found the correct shell!");
    } else {
      score -= 1;
      _speak("Try Again! That's the wrong shell.");
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(isCorrect ? "Congratulations!" : "Try Again!"),
          content: Text(
            isCorrect
                ? "You found the correct shell!"
                : "That's the wrong shell. Please select the correct one.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isCorrect) {
                  _generateRandomQuestion();
                }
                setState(() {
                  isProcessingAnswer = false;
                });
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double shellSize =
        (MediaQuery.of(context).size.shortestSide / gridSize) - 16;

    return Consumer<LanguageController>(
      builder: (context, languageController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(languageController.currentLanguage == 'en'
                ? "Demo: Mermaid Game"
                : "Demostración: Juego de Sirenas"),
            actions: const [
              LanguageToggleButton(),
            ],
          ),
          body: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      question,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridSize,
                      ),
                      itemCount: gridSize * gridSize,
                      itemBuilder: (context, index) {
                        int shellIndex = index + 1;
                        return GestureDetector(
                          onTap: () => _onShellTap(shellIndex),
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                'assets/MathC&S/shell.svg',
                                width: shellSize,
                                height: shellSize,
                              ),
                              if (shellIndex == seahorsePosition)
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/MathC&S/seahorse.svg',
                                      width: shellSize / 2,
                                      height: shellSize / 2,
                                    ),
                                  ),
                                ),
                              if (shellIndex == _mermaidCurrentPosition)
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/MathC&S/mermaid.svg',
                                      width: shellSize / 1.5,
                                      height: shellSize / 1.5,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Score: $score",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
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
}
