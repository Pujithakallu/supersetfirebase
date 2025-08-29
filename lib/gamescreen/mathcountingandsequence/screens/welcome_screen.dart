import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'home.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> _randomOffsets;

  static Offset _generateRandomOffset() {
    final random = math.Random();
    return Offset(
      (random.nextDouble() * 2 - 1) * 2.0,
      (random.nextDouble() * 2 - 1) * 2.4,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _randomOffsets = List.generate(3, (_) => _generateRandomOffset());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final borderColor = Colors.white.withOpacity(0.5);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[300]!, Colors.purple[300]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                width: 4,
                color: borderColor,
              ),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 4,
                      color: ColorTween(begin: borderColor, end: Colors.white)
                          .evaluate(CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeInOut,
                      ))!,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (_, child) {
                            return Stack(
                              children: [
                                Positioned(
                                  left: screenSize.width / 2 - 140,
                                  top: screenSize.height / 4 - 140,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(140),
                                      border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 2),
                                    ),
                                    child: Image.asset(
                                      'assets/MathC&S/seahorse-2.png',
                                      width: 280,
                                      height: 280,
                                    ),
                                  ),
                                ),
                                ..._randomOffsets.map((offset) {
                                  final currentOffset = Offset(
                                    screenSize.width *
                                        (0.5 +
                                            offset.dx *
                                                0.3 *
                                                math.sin(_controller.value *
                                                    2 *
                                                    math.pi)),
                                    screenSize.height *
                                        (0.3 +
                                            offset.dy *
                                                0.3 *
                                                math.cos(_controller.value *
                                                    2 *
                                                    math.pi)),
                                  );
                                  return Positioned(
                                    left: currentOffset.dx - 60,
                                    top: currentOffset.dy - 60,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Image.asset(
                                        'assets/MathC&S/jelly.png',
                                        width: 120,
                                        height: 120,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Counting & Sequencing',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple[700],
                shadows: [
                  Shadow(
                    blurRadius: 8,
                    color: Colors.purple.withOpacity(0.2),
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 300.ms)
                .shimmer(
                  duration: 1200.ms,
                  color: Colors.white.withOpacity(0.3),
                )
                .then()
                .shake(
                  hz: 2,
                  curve: Curves.easeInOut,
                )
                .then(delay: 400.ms)
                .slideY(
                  begin: 0.1,
                  curve: Curves.easeInOut,
                ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              text: "Play Now!",
              color: Colors.green.shade400,
              icon: Icons.play_arrow,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MyHomeScreen())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String text,
      required Color color,
      required IconData icon,
      required VoidCallback onPressed}) {
    return Animate(
      effects: [SlideEffect(duration: 0.5.seconds)],
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          icon: Icon(icon, color: Colors.white, size: 20),
          label: Text(
            text,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      ),
    );
  }
}
