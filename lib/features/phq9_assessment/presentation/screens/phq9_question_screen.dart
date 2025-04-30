import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

import '../bloc/phq9_bloc.dart';
import '../bloc/phq9_event.dart';
import '../bloc/phq9_state.dart';
import 'phq9_result_screen.dart';

class Phq9QuestionScreen extends StatelessWidget {
  const Phq9QuestionScreen({super.key});

  final List<String> options = const [
    "Not at all",
    "Several days",
    "More than half the days",
    "Nearly every day",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: const Text(
          "PHQ-9 Assessment",
          style: TextStyle(
            color: AppColors.lighFont,
            fontSize: 18,
          ),
        ),
      )),
      body: BlocConsumer<Phq9Bloc, Phq9State>(
        listener: (context, state) {
          if (state is Phq9ResultState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Phq9ResultScreen(
                  totalScore: state.totalScore,
                  severity: state.severity,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Phq9QuestionState) {
            final question = state.currentQuestion;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      "Question ${state.currentIndex + 1} of ${state.questions.length}",
                      style: const TextStyle(
                          fontSize: 18, color: AppColors.darkFont)),
                  const SizedBox(height: 20),
                  Text(question.questionText,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkFont,
                      )),
                  const SizedBox(height: 30),
                  ...List.generate(options.length, (index) {
                    return RadioListTile<int>(
                      value: index,
                      groupValue: question.selectedOption,
                      title: Text(
                        options[index],
                        style: TextStyle(
                          color: AppColors.darkFont,
                          fontSize: 16,
                        ),
                      ),
                      onChanged: (val) {
                        context.read<Phq9Bloc>().add(AnswerSelected(val!));
                      },
                    );
                  }),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: question.selectedOption != -1
                        ? () =>
                            context.read<Phq9Bloc>().add(NextQuestionPressed())
                        : null,
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: AppColors.lighFont,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
