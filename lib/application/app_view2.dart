import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_theme.dart';
import 'package:soul_space/features/splash_screen/presentation/pages/splash_page.dart';

class SoulSpaceApp extends StatelessWidget {
  const SoulSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.lightTheme,
      home: const SplashPage(),
    );
  }
}
