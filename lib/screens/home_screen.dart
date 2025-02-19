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

class HomeScreen extends StatelessWidget {
  final String pin;

  HomeScreen({required this.pin, Key? key}) : super(key: key);

  final List<Map<String, dynamic>> games = [
    {
      'title': 'Math Mingle',
      'backgroundImage': 'assets/images/math_mingle.png',
      'icon': Icons.calculate,
      'color': Color(0xFFFF9999),
      'description': 'Fun with numbers!',
      'progress': 0,
      'route': (String pin) => MathMingleApp(),
    },
    {
      'title': 'Math Equations',
      'backgroundImage': 'assets/images/math_equations.png',
      'icon': Icons.functions,
      'color': Color(0xFF99FF99),
      'description': 'Master equations!',
      'progress': 0,
      'route': (String pin) => MyApp(),
    },
    {
      'title': 'Math Operators',
      'backgroundImage': 'assets/images/math_operators.png',
      'icon': Icons.addchart,
      'color': Color(0xFF9999FF),
      'description': 'Learn new symbols & more!',
      'progress': 0,
      'route': (String pin) => Operators(userPin: pin), // Fix: Pass the correct pin
    },
    {
      'title': 'Studio',
      'backgroundImage': 'assets/images/art_studio.png',
      'icon': Icons.palette,
      'color': Color(0xFFFFB366),
      'description': 'Draw and create!',
      'progress': 0,
      'route': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context).pin;
    final Size screenSize = MediaQuery.of(context).size;
    final int crossAxisCount = screenSize.width < 600
        ? 2
        : screenSize.width < 900
            ? 3
            : 4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) =>  LoginScreen()),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: Color(0xFF6C63FF),
              size: 26,
            ),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-Screen Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
            ),
          ),

          // UI Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title Section
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Icon(Icons.school, size: 40, color: Colors.blue),
                      SizedBox(height: 8),
                      Text(
                        "Hi, $pin!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Welcome to the Fun Zone!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.rocket_launch, color: Colors.black),
                        label: Text("Choose your adventure!"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Game Tiles in a Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: games.map((game) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: GestureDetector(
                            onTap: () {
                              if (game['route'] != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => game['route'](pin), // Fix: Pass pin dynamically
                                  ),
                                );
                              }
                            },
                            child: Column(
                              children: [
                                // Game Image
                                Container(
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

                                SizedBox(height: 10),

                                // Title
                                Text(
                                  game['title'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: 6),

                                // Icon
                                Icon(
                                  game['icon'] as IconData,
                                  size: 30,
                                  color: game['color'] as Color,
                                ),

                                SizedBox(height: 6),

                                // Description
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    game['description'] as String,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(height: 5),

                                // Progress
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Progress: 0%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.bar_chart, color: Colors.blue, size: 16),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
