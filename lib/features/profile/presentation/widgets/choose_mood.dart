import 'package:flutter/material.dart';

class ChooseMood extends StatelessWidget {
  const ChooseMood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Text('How are you feeling today?'),
            Text('Choose a mood below'),
            MoodButton(mood: 'Happy'),
            MoodButton(mood: 'Sad'),
            MoodButton(mood: 'Angry'),
            MoodButton(mood: 'Anxious'),
          ],
        ),
      ),
    );
  }
}

class MoodButton extends StatelessWidget {
  final String mood;

  const MoodButton({required this.mood, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(mood),
    );
    return const Placeholder();
  }
}
