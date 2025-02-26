import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import '../gamescreen/mathmingle/main.dart';
import '../gamescreen/mathequations/main.dart';
import '../gamescreen/mathoperations/main.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

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
  }

  final List<Map<String, dynamic>> games = [
    {
      'title': 'Math Mingle',
      'backgroundImage': 'assets/images/math_mingle.png',
      'icon': Icons.calculate,
      'color': Color(0xFFFF9999),
      'description': 'Fun with numbers!',
      'route': (String pin) => MathMingleApp(),
    },
    {
      'title': 'Math Equations',
      'backgroundImage': 'assets/images/math_equations.png',
      'icon': Icons.functions,
      'color': Color(0xFF99FF99),
      'description': 'Master equations!',
      'route': (String pin) => MyApp(),
    },
    {
      'title': 'Math Operators',
      'backgroundImage': 'assets/images/math_operators.png',
      'icon': Icons.addchart,
      'color': Color(0xFF9999FF),
      'description': 'Learn new symbols & more!',
      'route': (String pin) => Operators(userPin: pin),
    },
    {
      'title': 'Studio',
      'backgroundImage': 'assets/images/art_studio.png',
      'icon': Icons.palette,
      'color': Color(0xFFFFB366),
      'description': 'Draw and create!',
      'route': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => LoginScreen()),
            ),
          ),
        ),
        actions: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
              icon: const Icon(
                Icons.logout_rounded,
                color: Color(0xFF6C63FF),
                size: 26,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Container with fallback color
          Positioned.fill(
            child: Container(
              color: Colors.white,
              child: Image.asset(
                "assets/images/background.png",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.white); // Fallback if image fails
                },
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      const SizedBox(height: 4),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Welcome to the Fun Zone!",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.rocket_launch, color: Colors.black),
                          label: const Text("Choose your adventure!"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amberAccent,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Game Tiles
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: games.map((game) {
                      return MouseRegion(
                        cursor: game['route'] != null 
                            ? SystemMouseCursors.click 
                            : SystemMouseCursors.basic,
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
                              ScaleTransition(
                                scale: _scaleAnimation,
                                child: Container(
                                  width: 160,
                                  height: 160,
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
                                color: game['color'] as Color,
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  game['description'] as String,
                                  style: const TextStyle(fontSize: 12, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}