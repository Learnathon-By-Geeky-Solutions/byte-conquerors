import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soul_space/core/config/assets/app_vectors.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/onboarding/domain/models/onboarding_content.dart';

class OnboardingStepPage extends StatelessWidget {
  const OnboardingStepPage({
    super.key,
    required this.currentIndex,
    required this.onboardingContent,
  });
  final int currentIndex;
  final List<OnboardingContent> onboardingContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: PageView.builder(
          itemCount: onboardingContent.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  AppVectors.logoPurple,
                  height: 15.0,
                ),
                SvgPicture.asset(
                  onboardingContent[index].vectorPath,
                  height: 300.0,
                ),
                Text(
                  onboardingContent[index].title,
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 30.0,
                  ),
                  child: Text(
                    onboardingContent[index].description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
