import 'package:flutter/material.dart';
import 'package:soul_space/components/universal_large_button.dart';
import 'package:soul_space/features/auth/presentation/signup/pages/sign_up_page.dart';
import 'package:soul_space/features/onboarding/data/datasources/onboarding_content_list.dart';
import 'package:soul_space/features/onboarding/domain/models/onboarding_content.dart';
import 'package:soul_space/features/onboarding/presentation/pages/onboarding_step_page.dart';
import 'package:soul_space/features/onboarding/presentation/widgets/page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OnboardingContent> onboardingContent =
        OnboardingContentList().onboardingContent;
    int currentIndex = 0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: OnboardingStepPage(
                currentIndex: currentIndex,
                onboardingContent: onboardingContent,
              ),
            ),
            PageIndicator(
              onboardingContent: onboardingContent,
              currentIndex: currentIndex,
            ),
            UniversalLargeButton(
              buttonText: 'Get Started',
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignUpPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
