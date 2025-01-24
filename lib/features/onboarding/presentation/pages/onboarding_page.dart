import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        PageView.builder(itemBuilder: (itemBuilder, index) {
          return Container(
            child: Column(
              children: [
                Text('Onboarding Page $index'),
                ElevatedButton(
                  onPressed: () {
                    if (index == 2) {
                      Navigator.of(context).pushNamed('/home');
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          );
        }),
      ],
    ));
  }
}
