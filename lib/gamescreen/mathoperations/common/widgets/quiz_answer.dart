import 'package:flutter/material.dart';

class QuizAnswerCard extends StatelessWidget {
  const QuizAnswerCard({
    Key? key,
    required this.question,
    required this.selectedAnswer,
    required this.correctAnswer,
  }) : super(key: key);

  final String question;
  final String selectedAnswer;
  final String correctAnswer;

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = selectedAnswer.toLowerCase() == correctAnswer.toLowerCase();
    final bool isSelected = selectedAnswer.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? (isCorrect ? Colors.green : Colors.red) : Colors.white54,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white70,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (isSelected)
              isCorrect
                  ? buildCorrectIcon()
                  : buildWrongIcon(),
          ],
        ),
      ),
    );
  }
}

Widget buildCorrectIcon() => const CircleAvatar(
  radius: 15,
  backgroundColor: Colors.green,
  child: Icon(
    Icons.check,
    color: Colors.white,
  ),
);

Widget buildWrongIcon() => const CircleAvatar(
  radius: 15,
  backgroundColor: Colors.red,
  child: Icon(
    Icons.close,
    color: Colors.white,
  ),
);
