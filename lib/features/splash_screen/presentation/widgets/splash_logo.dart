import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:soul_space/core/config/assets/app_images.dart';
import 'package:soul_space/features/splash_screen/viewmodel/splash_navigation.dart';

class SplashLogo extends StatefulWidget {
  const SplashLogo({super.key});

  @override
  State<SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<SplashLogo> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logoLight,
      width: 100,
    )
        .animate(
          delay: 500.ms,
          onComplete: (controller) => SplashNavigation().redirect(context),
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
}
