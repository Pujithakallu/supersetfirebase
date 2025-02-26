import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngine {
  static final instance = FirebaseAnalytics.instance;

  /// Initialize Firebase Analytics
  static Future<void> init() async {
    await instance.setAnalyticsCollectionEnabled(true);
  }

  /// Log audio button clicks (Formatted to Match the Other Team's Format)
  static Future<void> logAudioButtonClick_MathMingle(String word, int chapter) async {
    print('Audio button clicked for word: $word in Chapter $chapter');
    await instance.logEvent(
      name: 'Math_mingle: audio_button_click',
      parameters: <String, Object>{
        'word': word,
        'chapter': 'Chapter $chapter',
      },
    );
  }
}