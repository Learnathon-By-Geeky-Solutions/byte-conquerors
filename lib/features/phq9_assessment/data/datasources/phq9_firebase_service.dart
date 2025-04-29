import 'package:cloud_firestore/cloud_firestore.dart';

class Phq9FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> savePhq9Score(int score) async {
    try {
      final userDoc = _db.collection('users').doc(
          'user_id'); // You need to replace 'user_id' with actual user logic

      await userDoc.set({
        'phq9_score': score,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print("PHQ-9 Score saved: $score");
    } catch (e) {
      print("Error saving PHQ-9 score: $e");
    }
  }

  Future<int> fetchPhq9Score() async {
    try {
      final userDoc = await _db.collection('users').doc('user_id').get();
      return userDoc.data()?['phq9_score'] ?? 0;
    } catch (e) {
      print("Error fetching PHQ-9 score: $e");
      return 0;
    }
  }
}
