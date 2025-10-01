import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../widgets/MultipageContainer.dart';
import 'package:supersetfirebase/gamescreen/mathnumquest/FlashCards/PrimeNumberExamplesPage.dart';
import '../analytics_engine.dart';

class PrimeNumberInfoPage extends StatefulWidget {
  @override
  _PrimeNumberInfoPageState createState() => _PrimeNumberInfoPageState();
}

class _PrimeNumberInfoPageState extends State<PrimeNumberInfoPage> {
  final FlutterTts flutterTts = FlutterTts();
  List<Map<String, dynamic>>? pages;
  final String lessonType = 'prime_numbers';

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    final String jsonString =
        await rootBundle.loadString('assets/MathNumQuest/prime_lessons.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    setState(() {
      pages = List<Map<String, dynamic>>.from(jsonData['pages']);
    });
  }

  // Fixed speakText method
  void speakText(String text, String ttsLanguage, bool isEnglish) async {
    await flutterTts.setLanguage(ttsLanguage);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);

    // Log audio button click - now using the correct parameters
    String analyticsLanguage = AnalyticsEngine.getLanguageString(isEnglish);
    AnalyticsEngine.logAudioButtonClickLessons(analyticsLanguage, lessonType);
    print('Audio in prime logged');
  }
  
  Future<void> stopSpeaking() async {
    await flutterTts.stop();
  }

  void _onQuizPressed() {
    stopSpeaking(); // stop TTS before navigating
    print('Quiz in prime is logged');
    // Log lesson completion when Quiz button is clicked
    AnalyticsEngine.logLessonCompletion(lessonType);
    
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PrimeNumberPracticePage()),
    );
  }

  @override
  void dispose() {
    stopSpeaking(); // stop TTS when leaving page
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (pages == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return MultipageContainer(
      lessonType: lessonType,
      pages: pages!.map((page) {
        return (bool isEnglish) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          isEnglish ? page['text_en'] : page['text_es'],
                          style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 18, 3, 48),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            stopSpeaking();
                            // Fixed: Now passing isEnglish parameter correctly
                            speakText(
                              isEnglish ? page['text_en'] : page['text_es'],
                              isEnglish ? "en-US" : "es-ES",
                              isEnglish, // Added this parameter
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Image.asset(page['image'], height: 400),
                SizedBox(height: 20),
                if (page == pages!.last) // Only show quiz button on last page
                  ElevatedButton(
                    onPressed: _onQuizPressed,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      isEnglish ? 'Quiz' : 'examen',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
              ],
            );
      }).toList(),
    );
  }
}