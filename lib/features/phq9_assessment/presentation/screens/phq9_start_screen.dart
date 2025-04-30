import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/phq9_assessment/presentation/bloc/phq9_bloc.dart';
import 'package:soul_space/features/phq9_assessment/presentation/bloc/phq9_event.dart';

import 'phq9_question_screen.dart';

class Phq9StartScreen extends StatelessWidget {
  const Phq9StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Text(
          'PHQ-9 Assessment',
          style: ThemeData().textTheme.headlineLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.lighFont,
              ),
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      context.read<Phq9Bloc>().add(Phq9Restarted());
                      context.read<Phq9Bloc>().add(Phq9Started());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Phq9QuestionScreen()),
                      );
                    },
                    child: Text(
                      "Start Analyzing",
                      style: ThemeData().textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.lighFont),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
