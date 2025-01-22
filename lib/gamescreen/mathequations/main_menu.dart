import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Math Equations',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/learn');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32), // Set button padding
                    textStyle:
                        const TextStyle(fontSize: 24), // Set button text size
                    elevation: 6, // Set button elevation (shadow)
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
                        vertical: 16, horizontal: 32), // Set button padding
                    textStyle:
                        const TextStyle(fontSize: 24), // Set button text size
                    elevation: 6, // Set button elevation (shadow)
                  ),
                  child: const Text('Play'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
