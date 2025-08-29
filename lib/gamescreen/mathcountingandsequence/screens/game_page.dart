import 'package:flutter/material.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final int totalShells = 3; // Only one level with fixed shells
  int seahorsePosition = Random().nextInt(3);
  int attempts = 0;
  bool showGameOver = false;
  bool showCongratulations = false;
  bool hintUsed = false;
  String selectedLanguage = 'en';

  final Map<String, Map<String, String>> localizedText = {
    'en': {
      'title': 'Find the Seahorse!',
      'congratulations': 'Congratulations! You found the seahorse!',
      'gameOver': 'Game Over! Try again.',
      'hint': 'Hint: Try the ${Random().nextInt(3) + 1} shell',
      'tryAgain': 'Try Again',
      'playAgain': 'Play Again',
    },
    'es': {
      'title': '¡Encuentra el caballito de mar!',
      'congratulations': '¡Felicidades! ¡Encontraste el caballito de mar!',
      'gameOver': '¡Juego terminado! Inténtalo de nuevo.',
      'hint': 'Pista: Intenta la ${Random().nextInt(3) + 1} concha',
      'tryAgain': 'Inténtalo de nuevo',
      'playAgain': 'Jugar de nuevo',
    },
  };

  void toggleLanguage() {
    setState(() {
      selectedLanguage = selectedLanguage == 'en' ? 'es' : 'en';
    });
  }

  void checkShell(int index) {
    setState(() {
      attempts++;
      if (index == seahorsePosition) {
        showCongratulations = true;
      } else {
        showGameOver = true;
      }
    });
  }

  void resetGame() {
    setState(() {
      seahorsePosition = Random().nextInt(3);
      attempts = 0;
      showGameOver = false;
      showCongratulations = false;
      hintUsed = false;
    });
  }

  void showHint() {
    setState(() {
      hintUsed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localizedText[selectedLanguage]!['title']!),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: toggleLanguage,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localizedText[selectedLanguage]!['title']!,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            if (!showCongratulations && !showGameOver)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  totalShells,
                  (index) => GestureDetector(
                    onTap: () => checkShell(index),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 80,
                      height: 80,
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text(
                          localizedText[selectedLanguage]!['tryAgain']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (hintUsed && !showGameOver && !showCongratulations)
              Text(
                localizedText[selectedLanguage]!['hint']!,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            const SizedBox(height: 20),
            if (showGameOver)
              AlertDialog(
                title: Text(localizedText[selectedLanguage]!['gameOver']!),
                actions: [
                  TextButton(
                    onPressed: () {
                      resetGame();
                    },
                    child: Text(localizedText[selectedLanguage]!['tryAgain']!),
                  ),
                ],
              ),
            if (showCongratulations)
              AlertDialog(
                title:
                    Text(localizedText[selectedLanguage]!['congratulations']!),
                actions: [
                  TextButton(
                    onPressed: () {
                      resetGame();
                    },
                    child: Text(localizedText[selectedLanguage]!['playAgain']!),
                  ),
                ],
              ),
            if (!hintUsed && !showGameOver && !showCongratulations)
              ElevatedButton(
                onPressed: showHint,
                child: Text(localizedText[selectedLanguage]!['hint']!),
              ),
          ],
        ),
      ),
    );
  }
}
