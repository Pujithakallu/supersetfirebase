import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/image.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  int score = 0;

  void incrementScore() {
    setState(() {
      score += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Mathoperations/home_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score : ${score}',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
              ),
              const SizedBox(width: 300),
              ElevatedButton(
                onPressed: incrementScore,
                child: Text('Working on this page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}