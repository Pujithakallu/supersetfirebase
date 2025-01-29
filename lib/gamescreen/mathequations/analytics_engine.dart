import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngine {
  static final instance = FirebaseAnalytics.instance;

  static Future<void> init() async {
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }

  // log translate button clicks for Equation to Words
  static void logTranslateButtonClickETW(String language) async {
    print(
        'Equation to Words - Translate button clicked for language: $language');
    await instance.logEvent(
      name: 'Math_equations: eq_to_words_translate',
      parameters: <String, Object>{
        'language': language,
      },
    );
  }

  // log translate button clicks for Parts of Equations
  static void logTranslateButtonClickPOE(String language) async {
    print(
        'Parts Of Equations - Translate button clicked for language: $language');
    await instance.logEvent(
      name: 'Math_equations: parts_of_eq__translate',
      parameters: <String, Object>{
        'language': language,
      },
    );
  }

  // log translate button clicks for Learn Section
  static void logTranslateButtonClickLearn(String language) async {
    print('Learn Section - Translate button clicked for language: $language');
    await instance.logEvent(
      name: 'Math_equations: learn_section_translate',
      parameters: <String, Object>{
        'language': language,
      },
    );
  }

  // log audio button clicks
  static void logAudioButtonClick(bool isSpanish, String game) async {
    print(
        '$game - Audio button clicked for language: ${isSpanish ? 'Spanish' : 'English'}');
    await instance.logEvent(
      name: 'Math_equations: audio_button_click',
      parameters: <String, Object>{
        'language': isSpanish ? 'Spanish' : 'English',
        'game': game,
      },
    );
  }
}
