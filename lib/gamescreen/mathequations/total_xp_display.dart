import 'package:flutter/material.dart';

class TotalXpDisplay extends StatelessWidget {
  final int totalXp;

  const TotalXpDisplay({super.key, required this.totalXp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_events,
            color: Colors.yellow,
          ),
          const SizedBox(width: 8),
          Text(
            'Total Best: $totalXp',
            style: const TextStyle(
              fontFamily: 'sans-serif',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
