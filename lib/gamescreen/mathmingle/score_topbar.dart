// lib/gamescreen/mathmingle/score_topbar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/matching.dart'
    show GameData;
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart'
    show GameData1;

class TopBarWithScore extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  const TopBarWithScore({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    final matchingScore = Provider.of<GameData>(context).total;
    final memoryScore = Provider.of<GameData1>(context).total;
    final totalScore = matchingScore + memoryScore;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Text(
        'PIN: $userPin',
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Center(
            child: Text(
              'Score: $totalScore',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
