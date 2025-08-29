import 'package:flutter/material.dart';

class SequenceOptionButton extends StatelessWidget {
  final BuildContext context;
  final String text;
  final VoidCallback onPressed;

  const SequenceOptionButton({
    super.key,
    required this.context,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}