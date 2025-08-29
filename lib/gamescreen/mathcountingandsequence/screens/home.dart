import 'package:supersetfirebase/gamescreen/mathcountingandsequence/screens/shell_counting_game.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/analytics_engine.dart';
import 'count_match.dart';
import 'sequence.dart';
import 'demo_game.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AudioPlayer _audioPlayer;
  late AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache(prefix: 'assets/MathC&S/'); // Adjust the prefix as needed

    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    String audioPath = 'MathC&S/audio/game-music-loop.mp3';
    await _audioPlayer.play(AssetSource(audioPath));
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.setVolume(1.0); // Adjust volume as needed
  }

  void _stopBackgroundMusic() async {
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    _stopBackgroundMusic();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/MathC&S/p3.gif', // Ensure your image path is correct
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    AnalyticsEngine.logGameSelected("Count & Match");

                    _stopBackgroundMusic();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CountMatch()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text(
                    "Let's Count & Match",
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AnalyticsEngine.logGameSelected("Sequencing");

                    _stopBackgroundMusic();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SequencingPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text(
                    "Let's Order & Learn Sequence",
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AnalyticsEngine.logGameSelected("Shell Counting Game");

                    _stopBackgroundMusic();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MermaidGame()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text(
                    "Shell Counting Game",
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AnalyticsEngine.logGameSelected("Demo Game");
                    _stopBackgroundMusic();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DemoGame()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text(
                    "Demo Game",
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
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
