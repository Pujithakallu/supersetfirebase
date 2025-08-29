import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngine {
  static final instance = FirebaseAnalytics.instance;

  static Future<void> init() async {
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }

  // Log when a game is selected (e.g., from home or game screen)
  static void logGameSelected(String gameName) async {
    print('Game selected: $gameName');
    await instance.logEvent(
      name: 'game_selected',
      parameters: <String, Object>{
        'game_name': gameName,
      },
    );
  }

  // Log when language is toggled
  static void logLanguageToggle(String language) async {
    print('Language toggled to: $language');
    await instance.logEvent(
      name: 'language_toggle',
      parameters: <String, Object>{
        'language': language,
      },
    );
  }

  // Log when a shell is tapped in the Mermaid Game
  static void logShellTapped(int shellIndex, bool isCorrect) async {
    print('Shell tapped: $shellIndex, Correct: $isCorrect');
    await instance.logEvent(
      name: 'shell_tap',
      parameters: <String, Object>{
        'shell_index': shellIndex,
        'is_correct': isCorrect,
      },
    );
  }

  // Log when an audio button is clicked (if speech synthesis is used)
  static void logAudioButtonClick(String language, String game) async {
    print('$game - Audio button clicked for language: $language');
    await instance.logEvent(
      name: 'audio_button_click',
      parameters: <String, Object>{
        'language': language,
        'game': game,
      },
    );
  }

  // Navigation in Count Match game (to EightPage or SixPage)
  static void logCountMatchNavigation(String destinationPage) async {
    print('CountMatch - Navigated to $destinationPage');
    await instance.logEvent(
      name: 'count_match_nav',
      parameters: <String, Object>{
        'destination': destinationPage,
      },
    );
  }

  // Navigation in CountMatchDemo game (to FivePage or TwoPage)
  static void logDemoMatchNavigation(String destinationPage) async {
    print('CountMatchDemo - Navigated to $destinationPage');
    await instance.logEvent(
      name: 'demo_match_nav',
      parameters: <String, Object>{
        'destination': destinationPage,
      },
    );
  }

  // Sequence game option selected
  static void logSequenceGameOption(String optionName) async {
    print('Sequence Game - Option selected: $optionName');
    await instance.logEvent(
      name: 'sequence_option_selected',
      parameters: <String, Object>{
        'option': optionName,
      },
    );
  }
}
