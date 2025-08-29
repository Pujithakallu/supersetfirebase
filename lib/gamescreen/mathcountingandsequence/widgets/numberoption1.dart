import 'package:flutter/material.dart';

class NumberOptionButton1 extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const NumberOptionButton1(
      {super.key, required this.text,
        required this.backgroundColor,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 30)),
    );
  }
}