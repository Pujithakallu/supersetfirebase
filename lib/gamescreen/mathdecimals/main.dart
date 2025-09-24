import 'package:flutter/material.dart';
import 'package:supersetfirebase/gamescreen/mathdecimals/selection_pages/LearnSelection.dart';
import 'package:supersetfirebase/gamescreen/mathdecimals/selection_pages/GameSelectionDialog.dart';
import 'package:supersetfirebase/gamescreen/mathdecimals/screens/treasurehunt.dart';
import 'package:supersetfirebase/screens/teens_page.dart';

void main() {
  runApp(const DecimalApp());
}

class DecimalApp extends StatelessWidget {
  const DecimalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decimal App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const DecimalsPage(),
        '/learn': (context) => const LearnSelection(),
        '/play': (context) => const GameSelectionDialog(),
        '/practice': (context) => DecimalTreasureHuntGame(),
      },
    );
  }
}

class DecimalsPage extends StatelessWidget {
  const DecimalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Decimals', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const TeensPage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/MathDecimals/demo1.jpg',
                    width: screenWidth > 1200
                        ? screenWidth * 0.55
                        : screenWidth,
                    height: screenHeight * 0.95,
                    fit: screenWidth > 600 ? BoxFit.contain : BoxFit.fitWidth,
                    alignment: Alignment.center,
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 400),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton('Learn', Colors.green.shade600,
                                context, '/learn', screenWidth, screenHeight),
                            _buildButton('Play', Colors.green.shade600,
                                context, '/play', screenWidth, screenHeight),
                            _buildButton('Practice', Colors.green.shade600,
                                context, '/practice', screenWidth, screenHeight),
                          ],
                        ),
                        Text(
                          "LET'S LEARN DECIMALS",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.4),
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, BuildContext context,
      String route, double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
