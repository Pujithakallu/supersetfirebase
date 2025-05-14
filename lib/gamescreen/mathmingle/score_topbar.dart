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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          Builder(
            builder: (context) {
              final screenWidth = MediaQuery.of(context).size.width;
              final double buttonSize = screenWidth < 600 ? 30 : 50;
              final double iconSize = screenWidth < 600 ? 18 : 28;

              return SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: RawMaterialButton(
                  onPressed: onBack ?? () => Navigator.pop(context),
                  fillColor: Colors.lightBlue,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  constraints: BoxConstraints.tightFor(
                    width: buttonSize,
                    height: buttonSize,
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: iconSize,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),

          // Centered PIN
          Expanded(
            child: Builder(
              builder: (context) {
                final screenWidth = MediaQuery.of(context).size.width;
                final double fontSize = screenWidth < 600 ? 12 : 16;
                final double horizontalPadding = screenWidth < 600 ? 10 : 16;
                final double verticalPadding = screenWidth < 600 ? 6 : 8;
                final double borderRadius = screenWidth < 600 ? 10 : 15;

                return Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(borderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'PIN: $userPin',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Score
          Builder(
            builder: (context) {
              final screenWidth = MediaQuery.of(context).size.width;
              final double fontSize = screenWidth < 600 ? 12 : 16;
              final double horizontalPadding = screenWidth < 600 ? 10 : 16;
              final double verticalPadding = screenWidth < 600 ? 6 : 8;
              final double borderRadius = screenWidth < 600 ? 10 : 15;

              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Score: $totalScore',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );

  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
