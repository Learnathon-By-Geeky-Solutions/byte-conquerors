import 'package:flutter/material.dart';
import 'package:soul_space/features/onboarding/domain/models/onboarding_content.dart';
import 'package:soul_space/features/onboarding/presentation/widgets/page_indicator_dot.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.onboardingContent,
    required this.currentIndex,
  });

  final List<OnboardingContent> onboardingContent;
  final dynamic currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingContent.length,
        (index) => PageIndicatorDot(
          index: index,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}
