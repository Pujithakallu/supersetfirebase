// Define this class in a separate Dart file, e.g., global_quiz_state.dart
class GlobalQuizState {
  static final GlobalQuizState _singleton = GlobalQuizState._internal();

  factory GlobalQuizState() {
    return _singleton;
  }

  GlobalQuizState._internal();

  int score = 0;
  int currentLevel = 1;
}
