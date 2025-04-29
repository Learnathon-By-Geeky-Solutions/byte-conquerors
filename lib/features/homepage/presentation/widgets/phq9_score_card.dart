import 'package:flutter/material.dart';
import 'package:soul_space/features/phq9_assessment/data/datasources/phq9_firebase_service.dart';

class Phq9ScoreWidget extends StatefulWidget {
  const Phq9ScoreWidget({super.key});

  @override
  State<Phq9ScoreWidget> createState() => _Phq9ScoreWidgetState();
}

class _Phq9ScoreWidgetState extends State<Phq9ScoreWidget> {
  int? _score;
  String? _severity;
  bool _loading = true;

  final _firebaseService = Phq9FirebaseService();

  @override
  void initState() {
    super.initState();
    _loadScore();
  }

  Future<void> _loadScore() async {
    final score = await _firebaseService.fetchPhq9Score();
    setState(() {
      _score = score;
      _severity = _determineSeverity(score);
      _loading = false;
    });
  }

  String _determineSeverity(int score) {
    if (score <= 4) return 'Minimal';
    if (score <= 9) return 'Mild';
    if (score <= 14) return 'Moderate';
    if (score <= 19) return 'Moderately Severe';
    return 'Severe';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple, width: 1),
      ),
      child: _score != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Last PHQ-9 Score',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Score: $_score',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Severity: $_severity',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          : const Text('No score data found. Start your first assessment.'),
    );
  }
}
