import 'package:flutter/material.dart';

class WrongAnswerPage extends StatelessWidget {
  final int score; // Add this line to hold the score

  const WrongAnswerPage({super.key, required this.score}); // Update this constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wrong Answer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Oops! Your answer is incorrect.',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text('Score: $score',
                style: const TextStyle(fontSize: 24)), // Display the score
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Try Again', style: TextStyle(fontSize: 23)),
            ),
          ],
        ),
      ),
    );
  }
}
