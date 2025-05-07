 import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateGameScore(String pin, String gameKey, int newScore) async {
    final userDoc = users.doc(pin);
    final snapshot = await userDoc.get();

    if (!snapshot.exists) {
      await userDoc.set({});
    }
    print('Updating $gameKey to $newScore for user $pin');
    await userDoc.set({gameKey: newScore}, SetOptions(merge: true));
    await updateTotalScore(pin);
  }

  Future<void> updateTotalScore(String pin) async {
    final userDoc = users.doc(pin);
    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final score1 = data['MathMingle'] ?? 0;
      final score2 = data['MathEquations'] ?? 0;
      final score3 = data['MathOperators'] ?? 0;
      final total = score1 + score2 + score3;
      print('Updated TotalBestScore: $total');
      await userDoc.set({'TotalBestScore': total}, SetOptions(merge: true));
    }
  }

  Future<Map<String, int>> getUserScores(String pin) async {
    final doc = await users.doc(pin).get();
    if (!doc.exists) {
      print('No scores found for $pin');
      return {
        'MathMingle': 0,
        'MathEquations': 0,
        'MathOperators': 0,
        'TotalBestScore': 0,
      };
    }
    final data = doc.data() as Map<String, dynamic>;
    return {
      'MathMingle': data['MathMingle'] ?? 0,
      'MathEquations': data['MathEquations'] ?? 0,
      'MathOperators': data['MathOperators'] ?? 0,
      'TotalBestScore': data['TotalBestScore'] ?? 0,
    };
  }
  
  // To get user score in each game separately using user pin and gameKey
  Future<int> getUserScoresForGame(String pin, String gameKey) async {
    final doc = await users.doc(pin).get();
    if (!doc.exists) {
      print('No scores found for $pin');
      return 0;
    }
    final data = doc.data() as Map<String, dynamic>;
    return data[gameKey];
  }
}
