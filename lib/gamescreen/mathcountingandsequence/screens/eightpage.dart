import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class EightPage extends StatelessWidget {
  final player = AudioPlayer();
  final audioCache = AudioCache(prefix: 'assets/MathC&S/');

  EightPage({super.key});

  void playSound(String soundPath) async {
    await player.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    playSound('audio/game-wrong.mp3');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wrong!',
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
              Icons.cancel_presentation_outlined,
              size: 120,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 48),
            const Center(
              child: Text(
                'You Are Wrong!',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // Define what to do when "Try Again" button is pressed

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(120.0),
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context); // This will go back to the previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(120.0),
                ),
              ),
              child: const Text(
                'EXIT',
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
