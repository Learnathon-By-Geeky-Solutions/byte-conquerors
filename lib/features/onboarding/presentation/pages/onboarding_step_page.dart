import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soul_space/core/config/assets/app_vectors.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class OnboardingStepPage extends StatelessWidget {
  const OnboardingStepPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                AppVectors.logoPurple,
              ),
              Text(
                'Be happy !',
                style: TextStyle(
                  color: AppColors.primaryPurple,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 30.0,
                ),
                child: Text(
                  'Get what you want. Get better with us. Join our community and start your journey towards a happier and more fulfilling life.',
                  style: TextStyle(
                    color: AppColors.purpleAccent,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
