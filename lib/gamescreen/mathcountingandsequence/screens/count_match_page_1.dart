import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'fivepage.dart';
import 'twopage.dart';
class CountMatchPage1 extends StatefulWidget {
  const CountMatchPage1({super.key});

  @override
  _CountMatchPage1State createState() => _CountMatchPage1State();
}

class _CountMatchPage1State extends State<CountMatchPage1> {
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
                        ? 'Veamos cuántas uvas tenemos'
                        : 'Let\'s see how many grapes we have',
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
                          ? 'Veamos cuántas uvas tenemos'
                          : 'Let\'s see how many grapes we have';
                      await flutterTts
                          .setLanguage(showSpanish ? 'es-ES' : 'en-US');
                      await flutterTts.speak(text);
                    },
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Speak', style: TextStyle(fontSize: 20.0)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                      child: Image.asset('assets/MathC&S/grapes.png'),
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
                        MaterialPageRoute(builder: (context) => FivePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(
                      showSpanish ? 'CINCO' : 'Five',
                      style: const TextStyle(fontSize: 30.0, color: Colors.black),
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
                        MaterialPageRoute(builder: (context) => twoPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(
                      showSpanish ? 'DOS' : 'Two',
                      style: const TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showSpanish = !showSpanish;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
