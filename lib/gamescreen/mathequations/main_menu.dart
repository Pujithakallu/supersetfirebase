import 'package:flutter/material.dart';
import '../../utils/logout_util.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Mathequations/Background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  'Math Equations',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/learn');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          textStyle: const TextStyle(fontSize: 24),
                          elevation: 6,
                        ),
                        child: const Text('Learn'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/play');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          textStyle: const TextStyle(fontSize: 24),
                          elevation: 6,
                        ),
                        child: const Text('Play'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                color: Color(0xFF4A4A4A),
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
