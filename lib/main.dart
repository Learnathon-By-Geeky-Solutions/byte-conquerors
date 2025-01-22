import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_theme.dart';
import 'package:soul_space/features/splash_screen/presentation/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeManager.lightTheme,
      home: const SplashPage(),
    );
  }
}
