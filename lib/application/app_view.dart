import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_space/application/app_start/bloc/app_start_bloc.dart';
import 'package:soul_space/application/navigation/presentation/main_screen.dart';
import 'package:soul_space/core/config/theme/app_size.dart';
import 'package:soul_space/core/config/theme/app_theme.dart';
import 'package:soul_space/features/auth/presentation/signin/pages/sign_in_page.dart';

class SoulSpaceApp extends StatelessWidget {
  const SoulSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return ScreenUtilInit(
        designSize: MediaQuery.of(context).size.width > 600
            ? const Size(834, 1194) // Tablet design size
            : const Size(393, 852), // Mobile design size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // localizationsDelegates: [
            //   S.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            // supportedLocales: S.supportedLocales,
            themeMode: ThemeMode.system,
            theme: ThemeManager.lightTheme,
            darkTheme: ThemeManager.darkTheme,
            home: BlocBuilder<AppStartBloc, AppStartState>(
              builder: (context, state) {
                if (state is AppStartLoading) {
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                } else if (state is AppStartShowOnboarding) {
                  // return const OnboardingPage();
                  return MainScreen();
                } else if (state is AppStartShowLogin) {
                  return const SignInPage();
                } else if (state is AppStartShowHome) {
                  return MainScreen();
                }
                return const SizedBox();
              },
            ),
          );
        });
  }
}
