import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'count_match_page_1.dart';

class SixPage extends StatelessWidget {
  final player = AudioPlayer();
  final audioCache = AudioCache(prefix: 'assets/MathC&S/');

  SixPage({super.key});

  void playSound(String soundPath) async {
    await player.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    playSound('MathC&S/audio/game-correct.mp3');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Right Answer',
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        color: Colors.purple[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.check,
              size: 120,
              color: Colors.green,
            ),
            const SizedBox(height: 48),
            const Center(
              child: Text(
                'You Are Right!',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // Define what to do when "Continue" button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CountMatchPage1()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(120.0),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to MyHomePage
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                  ModalRoute.withName('/'),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(120.0),
                ),
              ),
              child: const Text(
                'Exit',
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
