import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soul_space/core/config/assets/app_vectors.dart';
import 'package:soul_space/features/onboarding/presentation/pages/onboarding_page.dart';

class SplashLogo extends StatefulWidget {
  const SplashLogo({super.key});

  @override
  State<SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<SplashLogo> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppVectors.logoWhite,
      width: 100,
    )
        .animate(
          delay: 500.ms,
          onComplete: (controller) => redirect(),
        )
        .slide(
          end: Offset(0, -5),
          duration: 1500.ms,
          curve: Curves.linear,
        )
        .scale(
          end: Offset(1.5, 1.5),
          duration: 1500.ms,
          curve: Curves.linear,
        )
        .fadeOut(
          delay: 1500.ms,
          duration: 250.ms,
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
