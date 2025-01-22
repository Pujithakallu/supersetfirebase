import 'package:flutter/material.dart';
import 'what_are_equations_detail.dart';
import 'importance_of_equations.dart';
import 'real_world_applications.dart';

class WhatAreEquations extends StatelessWidget {
  const WhatAreEquations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What are Equations?'),
      ),
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
                        vertical: 16, horizontal: 32), // Set button padding
                    textStyle:
                        const TextStyle(fontSize: 24), // Set button text size
                    elevation: 6, // Set button elevation (shadow)
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
                        vertical: 16, horizontal: 32), // Set button padding
                    textStyle:
                        const TextStyle(fontSize: 24), // Set button text size
                    elevation: 6, // Set button elevation (shadow)
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
                        vertical: 16, horizontal: 32), // Set button padding
                    textStyle:
                        const TextStyle(fontSize: 24), // Set button text size
                    elevation: 6, // Set button elevation (shadow)
                  ),
                  child: const Text('Real-world Applications of Equations'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
