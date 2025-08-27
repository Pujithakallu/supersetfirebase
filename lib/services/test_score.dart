import 'package:flutter/material.dart';
import 'firestore_score.dart';

class TestScoreScreen extends StatelessWidget {
  final String pin;
  final FirestoreService _firestoreService = FirestoreService();

  TestScoreScreen({required this.pin, super.key});

  void sendDummyScores(BuildContext context) async {
    print("Sending dummy scores for pin: $pin");
    await _firestoreService.updateGameScore(pin, 'MathMingle', 120);
    await _firestoreService.updateGameScore(pin, 'MathEquations', 190);
    await _firestoreService.updateGameScore(pin, 'MathOperators', 90);
    print("Dummy scores submitted for user:$pin");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Dummy scores submitted for $pin')),
    );
  }

  void showUserScores(BuildContext context) async {
    final scores = await _firestoreService.getUserScores(pin);
    print("📦 SCORES FETCHED: $scores");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Fetched Scores for $pin'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: scores.entries
                .map((entry) => Text("${entry.key}: ${entry.value}"))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Firestore Scores')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => sendDummyScores(context),
              icon: Icon(Icons.upload),
              label: Text('Send Dummy Scores'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => showUserScores(context),
              icon: Icon(Icons.visibility),
              label: Text('Fetch & Show Scores'),
            ),
          ],
        ),
      ),
    );
  }
}
