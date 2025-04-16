import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngine {
  static final instance = FirebaseAnalytics.instance;

  static Future<void> init() async {
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }

  // log translate button clicks for Equation to Words
  static Future<void> logTranslateButtonClickQuiz(String newLanguage) async {
    print(
        'Quiz Section - Translate button clicked for language: $newLanguage');
    await instance.logEvent(
      name: 'quiz_section_translate',
      parameters: <String, Object>{
        'language': newLanguage,
      },
    );
  }


  // log translate button clicks for Learn Section
  static Future<void> logTranslateButtonClickLearn(String newLanguage) async {
    print('Learn Section - Translate button clicked for language: $newLanguage');
    await instance.logEvent(
      name: 'learn_section_translate',
      parameters: <String, Object>{
        'language': newLanguage,
      },
    );
  }

  // log audio button clicks
  static Future<void> logAudioButtonClick(int currentLanguage) async {
    List<String> languageNames = ["English","Spanish"];
    String selectedLanguage = languageNames[currentLanguage]; 
    
    print(
        'Audio button clicked for language: $selectedLanguage');
    await instance.logEvent(
      name: 'tts_button_click',
      parameters: <String, Object>{
        'language': selectedLanguage,
      },
    );
  }
}
