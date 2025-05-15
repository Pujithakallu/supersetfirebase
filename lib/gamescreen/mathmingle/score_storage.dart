// lib/gamescreen/mathmingle/score_storage.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreStorage {
  // points at the "scores" collection in your Firestore
  static final CollectionReference<Map<String, dynamic>> _col =
      FirebaseFirestore.instance.collection('users');

  /// Fetch the combined best score for this userPin.
  /// Returns 0 if there's no document yet.
  static Future<int> getBestScore(String userPin) async {
    final docSnap = await _col.doc(userPin).get();
    if (!docSnap.exists) return 0;
    final data = docSnap.data()!;   
    return (data['MathMingle'] ?? 0) as int;
  }

  /// Persist a new combined best score if it beats the stored best.
  /// Uses merge so you won't clobber other fields if you add any later.
  static Future<void> setBestScore(String userPin, int score) async {
    final docRef = _col.doc(userPin);
    final docSnap = await docRef.get();
    final currentBest =
        docSnap.exists ? (docSnap.data()!['MathMingle'] ?? 0) as int : 0;

    if (score > currentBest) {
      await docRef.set({'MathMingle': score}, SetOptions(merge: true));
    }
  }
}
