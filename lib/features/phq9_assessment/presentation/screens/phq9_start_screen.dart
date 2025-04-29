import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/features/phq9_assessment/presentation/bloc/phq9_bloc.dart';
import 'package:soul_space/features/phq9_assessment/presentation/bloc/phq9_event.dart';

import 'phq9_question_screen.dart';

class Phq9StartScreen extends StatelessWidget {
  const Phq9StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PHQ-9 Assessment')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<Phq9Bloc>().add(Phq9Restarted());
            context.read<Phq9Bloc>().add(Phq9Started());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Phq9QuestionScreen()),
            );
          },
          child: const Text("Start Analyzing"),
        ),
      ),
    );
  }
}
