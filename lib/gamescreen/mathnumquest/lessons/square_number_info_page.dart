import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../widgets/MultipageContainer.dart';
import 'package:supersetfirebase/gamescreen/mathnumquest/FlashCards/SquaresPracticePage.dart';
import '../analytics_engine.dart';

class SquareNumberInfoPage extends StatefulWidget {
  @override
  _SquareNumberInfoPageState createState() => _SquareNumberInfoPageState();
}

class _SquareNumberInfoPageState extends State<SquareNumberInfoPage>{
  final FlutterTts flutterTts = FlutterTts();
  List<dynamic> lessonData = [];
  final String lessonType = 'square_numbers';

  Future<void> loadLessonData() async {
    final String jsonData =
        await rootBundle.loadString('assets/MathNumQuest/squarenum_lesson.json');
    setState(() {
      lessonData = json.decode(jsonData)['pages'];
    });
  }

  Future<void> speak(String text, bool isEnglish) async {
    await flutterTts.setLanguage(isEnglish ? 'en-US' : 'es-ES');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);

     // Log audio button click
    String language = AnalyticsEngine.getLanguageString(isEnglish);
    AnalyticsEngine.logAudioButtonClickLessons(language, lessonType);
     print('Audio in composite logged');
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
  }

  void _onQuizPressed() {
    stopSpeaking(); // stop TTS before navigating
    print('Quiz in composite is logged');
    // Log lesson completion when Quiz button is clicked
    AnalyticsEngine.logLessonCompletion(lessonType);
    
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PerfectSquareFinder()),
    );
  }

  @override
  void dispose() {
    stopSpeaking(); // stop TTS when leaving page
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadLessonData();
  }

  @override
  Widget build(BuildContext context) {
    if (lessonData.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return MultipageContainer(
      lessonType: lessonType,
      pages: lessonData.map<Widget Function(bool)>((page) {
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
                          isEnglish
                              ? page['english']['text']
                              : page['spanish']['text'],
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
                            speak(
                              isEnglish
                                  ? page['english']['text']
                                  : page['spanish']['text'],
                              isEnglish,
                            );
                          },
                        ),
                        if (page['english']['description'].isNotEmpty) ...[
                          SizedBox(height: 10),
                          Text(
                            isEnglish
                                ? page['english']['description']
                                : page['spanish']['description'],
                            style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 18, 3, 48),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Image.asset(page['image'], height: 400),
                if (page == lessonData.last)
                  ElevatedButton(
                    onPressed: _onQuizPressed,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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

void main(){
  runApp(MaterialApp(
    home: SquareNumberInfoPage(),
  ));
}

