import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/onboarding/presentation/pages/onboarding_page.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({super.key});

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 75,
          ),
          Text(
            "Well come!..",
            style: TextStyle(
              color: AppColors.fontWhite,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          )
              .animate(
                onComplete: (controller) => redirect(),
              )
              .fadeIn(
                delay: 1750.ms,
                duration: 500.ms,
              )
              .slide(
                duration: 500.ms,
                delay: 1750.ms,
                begin: Offset(0, 1),
              ),
        ],
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext contwxt) => OnboardingPage()),
    );
  }
}
