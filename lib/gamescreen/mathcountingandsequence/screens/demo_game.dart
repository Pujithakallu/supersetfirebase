import 'package:supersetfirebase/gamescreen/mathcountingandsequence/screens/shell_counting_game.dart';
import 'package:flutter/material.dart';
import 'count_match_demo.dart';
import 'sequence_demo.dart';

class DemoGame extends StatelessWidget {
  const DemoGame({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Game"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CountMatchDemo()),
              ),
              child: const Text(
                "Go to Count Match Game",
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SequenceDemo()),
              ),
              child: const Text(
                "Go to Sequence Game",
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MermaidGame(
                          isDemo: true,
                        )),
              ),
              child: const Text(
                "Go to Mermaid Game",
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
