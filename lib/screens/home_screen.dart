import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import '../gamescreen/mathmingle/main.dart';
import '../gamescreen/mathequations/main.dart';
import '../gamescreen/mathoperations/main.dart';

class HomeScreen extends StatefulWidget {
  final String pin;

  const HomeScreen({required this.pin, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late String pin;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  int totalScore = 0;

  @override
  void initState() {
    super.initState();
    pin = widget.pin;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Fetch total score when app loads
    getTotalBestScore(pin).then((score) {
      setState(() {
        totalScore = score;
      });
    });
  }

  Future<int> getTotalBestScore(String userPin) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(userPin);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final mathMingleScore = docSnapshot['MathMingle'] ?? 0;
      final mathEquationsScore = docSnapshot['MathEquations'] ?? 0;
      final mathOperatorsScore = docSnapshot['MathOperators'] ?? 0;

      return mathMingleScore + mathEquationsScore + mathOperatorsScore;
    }
    return 0;
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
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
          // Background
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.6), // Light overlay
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Title Section
                Column(
                  children: [
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: const Icon(Icons.school, size: 40, color: Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Hi, $pin!",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),

                const SizedBox(height: 20),

                // Game Tiles with Description and Icons at Bottom
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                    ),
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return MouseRegion(
                        onEnter: (_) {
                          // Change cursor to hand when hovered
                          SystemMouseCursors.click;
                        },
                        onExit: (_) {
                          // Revert cursor back to default arrow
                          SystemMouseCursors.basic;
                        },
                        child: GestureDetector(
                          onTap: () {
                            if (game['route'] != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => game['route'](pin),
                                ),
                              );
                            }
                          },
                          child: Column(
                            children: [
                              // Game Image
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(game['backgroundImage']),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Game Title
                              Text(
                                game['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              // Symbol Below the Title
                              Icon(
                                game['icon'],
                                size: 30,
                                color: Colors.blueAccent,
                              ),

                              // Description with Black Background
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  game['description'],
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
                    },
                  ),
                ),
              ],
            ),
          ),

          // Logout Icon at Bottom Right
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
