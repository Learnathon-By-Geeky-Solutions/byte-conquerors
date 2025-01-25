import 'package:flutter/material.dart';
import 'package:soul_space/features/onboarding/presentation/pages/onboarding_page.dart';

class SplashNavigation extends ChangeNotifier {
  final bool mounted = true;
  Future<void> redirect(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => OnboardingPage()),
      );
    }
  }
}
