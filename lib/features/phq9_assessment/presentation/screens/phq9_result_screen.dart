import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class Phq9ResultScreen extends StatelessWidget {
  final int totalScore;
  final String severity;

  const Phq9ResultScreen({
    Key? key,
    required this.totalScore,
    required this.severity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'PHQ-9 Result',
        style: TextStyle(
          color: AppColors.lighFont,
          fontSize: 18,
        ),
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Total Score: $totalScore",
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.darkFont,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(height: 16),
            Text("Severity: $severity",
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.darkFont,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
    );
  }
}
