import 'package:flutter/material.dart';
class NonClickableNumber1 extends StatelessWidget {
  final String text;

  const NonClickableNumber1({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}