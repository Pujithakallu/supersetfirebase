import 'dart:collection';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import 'package:supersetfirebase/gamescreen/mathcountingandsequence/utils/language_controller.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/utils/auth_service.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/analytics_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/widgets/language_toggle_button.dart';

class ShellCountingGame extends StatefulWidget {
  const ShellCountingGame({Key? key}) : super(key: key);

  @override
  _ShellCountingGameState createState() => _ShellCountingGameState();
}

class _ShellCountingGameState extends State<ShellCountingGame> {
  int score = 0;
  int level = 1;
  int targetIndex = 5;
  int seahorsePosition = -1;
  int sharkPosition = -1;
  String question = "";
  late VideoPlayerController _videoController;
  late AudioPlayer _audioPlayer;
  late FlutterTts _flutterTts;
  late LanguageController _languageController;
  Queue<int> ttsQueue = Queue<int>();
  bool isSpeaking = false;
  bool isProcessingAnswer = false;
  bool isAnimating = false;
  int _mermaidCurrentPosition = 1;
  List<int> _pathToTarget = [];

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _initializeVideoPlayer();
    _initializeAudioPlayer();
    _initializeTTS();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _languageController = Provider.of<LanguageController>(context, listen: false);
      _languageController.addListener(_updateQuestion);
      _generateNewQuestion(); // ✅ Call here only after controller is set
      _updateQuestion();
    });
  }

  @override
  void dispose() {
    _languageController.removeListener(_updateQuestion);
    _videoController.dispose();
    _audioPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  void _updateQuestion() {
    if (!mounted) return;
    setState(() {
      question = _languageController
          .translate('find_shell')
          .replaceAll('{ordinal}', _languageController.ordinal(targetIndex));
    });
  }

  void _initializeTTS() {
    _flutterTts = FlutterTts();
  }

  Future<void> _speakMermaidJump(int index) async {
    ttsQueue.add(index);
    await _processQueue();
  }

  Future<void> _loadProgress() async {
    final currentUser = AuthService().currentUser;
    if (currentUser != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('progress')
          .doc(currentUser.uid)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        setState(() {
          score = data?['score'] ?? 0;
          level = data?['level'] ?? 1;
        });
      }
    }
  }

  Future<void> _processQueue() async {
    if (isSpeaking || ttsQueue.isEmpty || !mounted) return;
    isSpeaking = true;
    int index = ttsQueue.removeFirst();
    String language = _languageController.currentLanguage;
    await _flutterTts.setLanguage(language == 'es' ? "es-ES" : "en-US");

    String toSpeak = _languageController.ordinal(index);
    await _flutterTts.speak(toSpeak);
    await _flutterTts.awaitSpeakCompletion(true);

    isSpeaking = false;
    if (ttsQueue.isNotEmpty) {
      await _processQueue();
    }
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
            debugPrint("Error initializing video: $error");
          });
  }

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.play(AssetSource('MathC&S/audio/ocea.mp3')).then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _audioPlayer.setVolume(0.1);
      });
    }).catchError((error) {
      debugPrint("Error playing audio: $error");
    });
  }

  void _generateNewQuestion() {
    int gridSize = level + 2;
    int totalShells = gridSize * gridSize;
    targetIndex = Random().nextInt(totalShells) + 1;

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateQuestion());

    seahorsePosition = -1;
    sharkPosition = -1;
    isProcessingAnswer = false;
    isAnimating = false;
    _mermaidCurrentPosition = 1;
    _pathToTarget = [];
  }

  void _showPopup(
      BuildContext context, String title, String message, bool correct) async {
    final languageController =
        Provider.of<LanguageController>(context, listen: false);

    bool gameFinished = correct && score == 50;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(languageController
              .translate(gameFinished ? "🎉 Game Complete!" : title)),
          content: Text(languageController.translate(gameFinished
              ? "You completed all 10 levels! Great job!"
              : message)),
          actions: [
            TextButton(
              child: Text(languageController.translate("OK")),
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  isAnimating = false;
                  if (gameFinished) {
                    score = 0;
                    level = 1;
                  } else if (correct) {
                    score += 5;
                    if (score % 20 == 0 && level < 10) {
                      level++;
                    }
                  } else {
                    sharkPosition = -1;
                  }

                  _mermaidCurrentPosition = 1;
                  isProcessingAnswer = false;
                });

                final currentUser = AuthService().currentUser;
                if (currentUser != null) {
                  await FirebaseFirestore.instance
                      .collection('progress')
                      .doc(currentUser.uid)
                      .set({
                    'level': level,
                    'score': score,
                  }, SetOptions(merge: true));
                }

                if (!gameFinished) {
                  _generateNewQuestion();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _onShellTap(int index) {
    if (isProcessingAnswer || isAnimating) return;

    setState(() {
      isProcessingAnswer = true;
      isAnimating = true;

      if (_mermaidCurrentPosition == index) {
        _showResult();
      } else {
        _pathToTarget = _calculatePath(_mermaidCurrentPosition, index);
        _pathToTarget.insert(0, _mermaidCurrentPosition);
        _animateMermaid();
      }
    });
  }

  List<int> _calculatePath(int start, int end) {
    List<int> path = [];
    int current = start;
    int gridSize = level + 2;
    int totalShells = gridSize * gridSize;

    while (current != end) {
      current++;
      if (current > totalShells) current = 1;
      path.add(current);
    }
    return path;
  }

  Future<void> _animateMermaid() async {
    if (_pathToTarget.isEmpty) {
      _showResult();
      return;
    }
    int currentPosition = _pathToTarget.removeAt(0);
    await _speakMermaidJump(currentPosition);
    if (!mounted) return;

    setState(() {
      _mermaidCurrentPosition = currentPosition;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    await _animateMermaid();
  }

  void _showResult() {
    setState(() {
      if (_mermaidCurrentPosition == targetIndex) {
        seahorsePosition = _mermaidCurrentPosition;
      } else {
        sharkPosition = _mermaidCurrentPosition;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      _showPopup(
        context,
        _mermaidCurrentPosition == targetIndex
            ? "Congratulations!"
            : "Game Over",
        _mermaidCurrentPosition == targetIndex
            ? "You found the correct shell!"
            : "Wrong shell! Try again.",
        _mermaidCurrentPosition == targetIndex,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    int gridSize = level + 2;
    int totalShells = gridSize * gridSize;

    return Consumer<LanguageController>(
      builder: (context, languageController, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF101828),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1D2333),
            title: Text(languageController.translate('Shell Game - Level $level')),
          ),
          body: Stack(
            children: [
              if (_videoController.value.isInitialized)
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      languageController.translate(question),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      languageController.translate('Score: $score'),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridSize,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: totalShells,
                          itemBuilder: (context, index) {
                            final cellNumber = index + 1;
                            return AspectRatio(
                              aspectRatio: 1.0,
                              child: GestureDetector(
                                onTap: isProcessingAnswer
                                    ? null
                                    : () => _onShellTap(cellNumber),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: SvgPicture.asset('assets/MathC&S/shell.svg'),
                                    ),
                                    if (seahorsePosition == cellNumber)
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset('assets/MathC&S/seahorse.svg'),
                                        ),
                                      ),
                                    if (sharkPosition == cellNumber)
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset('assets/shark.svg'),
                                        ),
                                      ),
                                    if (_mermaidCurrentPosition == cellNumber)
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset('assets/MathC&S/mermaid.svg'),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const LanguageToggleButton(),
                    const SizedBox(height: 10),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
