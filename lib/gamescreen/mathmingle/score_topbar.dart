// lib/gamescreen/mathmingle/score_topbar.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // for WidgetsBinding
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/matching.dart'
    show GameData;
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart'
    show GameData1;
import 'package:supersetfirebase/gamescreen/mathmingle/score_storage.dart';

class TopBarWithScore extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  const TopBarWithScore({super.key, this.onBack});

  @override
  _TopBarWithScoreState createState() => _TopBarWithScoreState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarWithScoreState extends State<TopBarWithScore> {
  int bestScore = 0;

  @override
  void initState() {
    super.initState();
    _loadBestScore();
  }

  Future<void> _loadBestScore() async {
    final pin = Provider.of<UserPinProvider>(context, listen: false).pin;
    final storedBest = await ScoreStorage.getBestScore(pin);
    setState(() => bestScore = storedBest);
  }

  @override
  Widget build(BuildContext context) {
    final userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    final matchingScore = Provider.of<GameData>(context).total;
    final memoryScore = Provider.of<GameData1>(context).total;
    final totalScore = matchingScore + memoryScore;

    // Persist & update if we beat the best
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (totalScore > bestScore) {
        ScoreStorage.setBestScore(userPin, totalScore);
        setState(() => bestScore = totalScore);
      }
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              Builder(
                builder: (context) {
                  final w = MediaQuery.of(context).size.width;
                  final btnSize = w < 600 ? 30.0 : 50.0;
                  final iconSize = w < 600 ? 18.0 : 28.0;
                  return SizedBox(
                    width: btnSize,
                    height: btnSize,
                    child: RawMaterialButton(
                      onPressed: widget.onBack ?? () => Navigator.pop(context),
                      fillColor: Colors.lightBlue,
                      shape: const CircleBorder(),
                      elevation: 2.0,
                      constraints: BoxConstraints.tightFor(
                          width: btnSize, height: btnSize),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: iconSize,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),

              // Score + Best
              Row(
                children: [
                  // Score
                  Builder(
                    builder: (context) {
                      final w = MediaQuery.of(context).size.width;
                      final fontSize = w < 600 ? 12.0 : 16.0;
                      final horizontalPd = w < 600 ? 10.0 : 16.0;
                      final verticalPd = w < 600 ? 6.0 : 8.0;
                      final borderRadius = w < 600 ? 10.0 : 15.0;

                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPd, vertical: verticalPd),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.9),
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
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8.0),
                  // Best Score
                  Builder(
                    builder: (context) {
                      final w = MediaQuery.of(context).size.width;
                      final fontSize = w < 600 ? 12.0 : 16.0;
                      final horizontalPd = w < 600 ? 10.0 : 16.0;
                      final verticalPd = w < 600 ? 6.0 : 8.0;
                      final borderRadius = w < 600 ? 10.0 : 15.0;

                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPd, vertical: verticalPd),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.9),
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
                          'Best: $bestScore',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // 🎯 Centered PIN
          Builder(
            builder: (context) {
              final w = MediaQuery.of(context).size.width;
              final fontSize = w < 600 ? 12.0 : 16.0;
              final horizontalPd = w < 600 ? 10.0 : 16.0;
              final verticalPd = w < 600 ? 6.0 : 8.0;
              final borderRadius = w < 600 ? 10.0 : 15.0;

              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPd, vertical: verticalPd),
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
              );
            },
          ),
        ],
      ),
    );
  }
}
