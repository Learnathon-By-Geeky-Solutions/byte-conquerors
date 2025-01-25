import 'package:flutter/material.dart';
import 'package:soul_space/components/universal_large_button.dart';
import 'package:soul_space/features/auth/presentation/signin_screen.dart';
import 'package:soul_space/features/onboarding/presentation/pages/onboarding_step_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: OnboardingStepPage(),
          ),
          UniversalLargeButton(
            buttonText: 'Get Started',
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SignInScreen()));
            },
          ),
        ],
      ),
    );
  }
}
