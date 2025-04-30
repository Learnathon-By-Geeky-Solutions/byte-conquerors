import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_event.dart';

class ChooseMoodStep extends StatefulWidget {
  const ChooseMoodStep();

  @override
  State<ChooseMoodStep> createState() => ChooseMoodStepState();
}

class ChooseMoodStepState extends State<ChooseMoodStep> {
  final List<String> emojis = ['😐', '🙂', '😄', '☹️', '😣'];
  final List<String> moods = ['Meh', 'Okay', 'Happy', 'Sad', 'Awful'];
  int _currentIndex = 2;

  void _onMoodSelected(int index) {
    setState(() => _currentIndex = index);
    context.read<UserProfileBloc>().add(UpdateMood(moods[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('How are you feeling?',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(emojis.length, (index) {
            return GestureDetector(
              onTap: () => _onMoodSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? AppColors.primary
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  emojis[index],
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
        Text(moods[_currentIndex], style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
