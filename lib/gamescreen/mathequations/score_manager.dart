class ScoreManager {
  int _score = 0;

  // Get the current score
  int get score => _score;

  // Increment the score
  void incrementScore(int points) {
    _score += points;
  }

  // Reset the score to 0
  void resetScore() {
    _score = 0;
  }
}
