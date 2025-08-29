import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/analytics_engine.dart';
import 'eightpage.dart';
import 'sixpage.dart';

class CountMatch extends StatefulWidget {
  const CountMatch({super.key});

  @override
  State<CountMatch> createState() => _CountMatchPageState();
}

class _CountMatchPageState extends State<CountMatch> {
  bool showSpanish = false;
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Count and Match'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                // Handle help action
              },
            ),
          ],
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'assets/MathC&S/p9.gif', // Ensure your image path is correct
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 50.0),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Text(
                    showSpanish
                        ? 'Veamos cuántas naranjas tenemos'
                        : 'Let\'s see how many oranges we have',
                    style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      String text = showSpanish
                          ? 'Veamos cuántas naranjas tenemos'
                          : 'Let\'s see how many oranges we have';
                      AnalyticsEngine.logAudioButtonClick(
                          showSpanish ? 'Spanish' : 'English', 'CountMatch');

                      await flutterTts.setLanguage('es-ES');
                      await flutterTts.speak(text);
                    },
                    icon: const Icon(Icons.volume_up),
                    label: const Text(
                      'Speak',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Center(
                  child: Container(
                    width: 330,
                    height: 186,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset('assets/MathC&S/oranges.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EightPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(
                      showSpanish ? 'OCHO' : 'Eight',
                      style:
                          const TextStyle(fontSize: 30.0, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SixPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(
                      showSpanish ? 'SEIS' : 'Six',
                      style:
                          const TextStyle(fontSize: 30.0, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 55.0), // Adjust horizontal padding
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showSpanish = !showSpanish;
                      });
                      final newLang = showSpanish ? 'Spanish' : 'English';
                      AnalyticsEngine.logLanguageToggle(newLang);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12), // Adjust vertical padding
                    ),
                    child: Text(showSpanish ? 'English' : 'Español',
                        style: const TextStyle(fontSize: 23)),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
