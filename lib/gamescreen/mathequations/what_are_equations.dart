import 'package:flutter/material.dart';
import 'what_are_equations_detail.dart';
import 'importance_of_equations.dart';
import 'real_world_applications.dart';
import '../../utils/logout_util.dart';

class WhatAreEquations extends StatelessWidget {
  const WhatAreEquations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/Mathequations/Background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const WhatAreEquationsDetail())),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    textStyle: const TextStyle(fontSize: 24),
                    elevation: 6,
                  ),
                  child: const Text('What Are Equations?'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImportanceOfEquations())),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    textStyle: const TextStyle(fontSize: 24),
                    elevation: 6,
                  ),
                  child: const Text('Importance of Equations in Mathematics'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RealWorldApplications())),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    textStyle: const TextStyle(fontSize: 24),
                    elevation: 6,
                  ),
                  child: const Text('Real-world Applications of Equations'),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: 24, // Adjusted for better positioning
            top: 16,
            child: FloatingActionButton(
              onPressed: () => Navigator.pop(context),
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF6C63FF),
                size: 26,
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: FloatingActionButton(
              onPressed: () => logout(context),
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.logout_rounded,
                color: Color(0xFF6C63FF),
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
