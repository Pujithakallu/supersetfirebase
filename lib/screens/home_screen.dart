import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'login_screen.dart';

import '../gamescreen/mathmingle/main.dart';
import '../gamescreen/mathequations/main.dart';
import '../gamescreen/mathoperations/main.dart';
import 'package:supersetfirebase/services/firestore_score.dart';
// import 'package:supersetfirebase/services/test_score.dart';
class HomeScreen extends StatefulWidget {
  final String pin;

  const HomeScreen({required this.pin, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  int totalScore = 0;
  final FirestoreService _scoreService = FirestoreService();
  Timer? scoreUpdateTimer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    refreshTotalScore();

    // Automatically update score every minute
    scoreUpdateTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      refreshTotalScore();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshTotalScore();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    scoreUpdateTimer?.cancel();
    super.dispose();
  }

  void refreshTotalScore() async {
    final scores = await _scoreService.getUserScores(widget.pin);
    setState(() {
      totalScore = scores['TotalBestScore'] ?? 0;
    });
  }

  final List<Map<String, dynamic>> games = [
    {
      'title': 'Math Mingle',
      'backgroundImage': 'assets/images/math_mingle.png',
      'description': 'Fun with numbers!',
      'icon': Icons.calculate,
      'route': (String pin) => MathMingleApp(),
    },
    {
      'title': 'Math Equations',
      'backgroundImage': 'assets/images/math_equations.png',
      'description': 'Master equations!',
      'icon': Icons.functions,
      'route': (String pin) => MyApp(),
    },
    {
      'title': 'Math Operators',
      'backgroundImage': 'assets/images/math_operators.png',
      'description': 'Learn new symbols & more!',
      'icon': Icons.show_chart,
      'route': (String pin) => Operators(userPin: pin),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginScreen()),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshTotalScore,
            tooltip: "Refresh Scores",
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 28),
                const SizedBox(width: 8),
                Text(
                  'Total Best: $totalScore',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Your background and overlay
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(color: Colors.white.withOpacity(0.6)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: const Icon(Icons.school, size: 40, color: Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Hi, ${widget.pin}!",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                  const SizedBox(height: 20),

             

                  // Test scores button
                  // ElevatedButton.icon(
                  //   onPressed: () async {
                  //     await Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) => TestScoreScreen(pin: widget.pin),
                  //       ),
                  //     );
                  //     refreshTotalScore(); 
                  //   },
                  //    icon: Icon(Icons.bug_report),
                  //    label: Text("Test/Set Dummy Scores"),
                  // ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double maxWidth = constraints.maxWidth;
                      double tileSize = maxWidth > 1000
                          ? maxWidth / 4 - 20
                          : maxWidth > 800
                              ? maxWidth / 3 - 20
                              : maxWidth > 500
                                  ? maxWidth / 2 - 20
                                  : maxWidth - 40;

                          return Center(
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.center,
                            children: games.map((game) {

                          return MouseRegion(
                            cursor: game['route'] != null
                                ? SystemMouseCursors.click
                                : SystemMouseCursors.basic,
                            child: GestureDetector(
                              onTap: () async {
                                if (game['route'] != null) {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => game['route'](widget.pin),
                                    ),
                                  );
                                  refreshTotalScore();
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: tileSize,
                                    height: tileSize,
                                    alignment: Alignment.center,
                                    child: ScaleTransition(
                                      scale: _scaleAnimation,
                                      child: Container(
                                        width: tileSize * 0.9,
                                        height: tileSize * 0.9,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(game['backgroundImage']),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 6,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    game['title'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 6),
                                  Icon(
                                    game['icon'] as IconData,
                                    size: 30,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      game['description'] as String,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                     );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
              child: const Icon(Icons.logout, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
