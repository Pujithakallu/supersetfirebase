import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supersetfirebase/services/firestore_score.dart';

class TotalXpProvider with ChangeNotifier {
  int _score = 0;
  int _bestScore = 0;  
  final FirestoreService _scoreService = FirestoreService();

  int get score => _score;
  int get bestScore => _bestScore;

  void resetScore() {
    _score = 0;
    notifyListeners();
  }

  Future<void> fetchBestScore(String pin) async {
    print('Fetching best score');
    try {      
        _bestScore = await _scoreService.getUserScoreForGame(pin, 'MathEquations');
        print('Fetched best score: $_bestScore');
        notifyListeners();
    } catch (e) {
      print('Error fetching best score: $e');
    }
  }

  Future<void> updateBestScoreIfNeeded(String userPin, int sessionScore) async {
    if (sessionScore > _bestScore) {
      _bestScore = sessionScore;
      notifyListeners();
      await _scoreService.updateUserScoreForGame(userPin, 'MathEquations', bestScore);
      print('Best score updated in Firestore: $_bestScore');
    }
  }
}
