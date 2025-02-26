// score_topbar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/matching.dart' show GameData;
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart' show GameData1;
import 'package:supersetfirebase/utils/logout_util.dart';

class TopBarWithScore extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  const TopBarWithScore({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    final matchingScore = Provider.of<GameData>(context).total;  // from matching.dart
    final memoryScore   = Provider.of<GameData1>(context).total; // from memory.dart
    final totalScore    = matchingScore + memoryScore;

    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Text(
            'PIN: $userPin',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            'Score: $totalScore',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout_rounded, color: Colors.blue),
          onPressed: () => logout(context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
