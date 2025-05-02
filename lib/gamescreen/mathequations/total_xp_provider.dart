import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supersetfirebase/services/firestore_score.dart';

class TotalXpProvider with ChangeNotifier {
  int _score = 0;
  int _bestScore = 0;  
  final FirestoreService _scoreService = FirestoreService();

  int get score => _score;
  int get bestScore => _bestScore;

  /// Initialize the provider by setting user ID and fetching best score.
  Future<void> init(String userId) async {
    // _userId = userId;
    await fetchBestScore('567');
  }

  void incrementScore(int increment) async {
    _score += increment;
    notifyListeners();
    await fetchBestScore('567');

    print('Comparing current score and best score');
    print('Current score: $_score');
    print('Best score: $_bestScore');

    if (_score > _bestScore) {
      _bestScore = _score;
      notifyListeners();
      // _updateBestScoreInFirestore(_score);
    }
    else{
      print('Current score is less than Best score');
    }
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }

  Future<void> fetchBestScore(String pin) async {
    print('Fetching best score');
    try {
      
        _bestScore = await _scoreService.getUserScoresForGame(pin, 'MathEquations');
        print('Fetched best score: $_bestScore');
        notifyListeners();
    } catch (e) {
      print('Error fetching best score: $e');
    }
  }

  Future<void> _updateBestScoreInFirestore(score) async {
    try {
      print('Updating the best score in Firestore');
      // DocumentReference userDocRef = _firestore.collection('users').doc('0001');
      // await userDocRef.set({'bestScore': score}, SetOptions(merge: true));
      // print('Best score updated');
    } catch (e) {
      print('Error updating best score in Firestore: $e');
    }
  }
}
