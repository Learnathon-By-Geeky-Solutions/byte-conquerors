import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_space/core/config/theme/app_theme.dart';
import 'package:soul_space/features/splash_screen/presentation/pages/splash_page.dart';

class SoulSpaceApp extends StatelessWidget {
  const SoulSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: MediaQuery.of(context).size.width > 600
            ? const Size(834, 1194) // Tablet design size
            : const Size(393, 852), // Mobile design size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeManager.lightTheme,
            home: const SplashPage(),
          );
        });
  }
}
