import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/application/navigation/bloc/navigation_bloc.dart';
import 'package:soul_space/application/navigation/bloc/navigation_state.dart';
import 'package:soul_space/core/widgets/bottom_nav.dart';
import 'package:soul_space/features/articles/presentation/screens/article_screen.dart';
import 'package:soul_space/features/gemini_prompts/presentation/screens/gemini_screen.dart';
import 'package:soul_space/features/homepage/presentation/screens/homepage_screen.dart';
import 'package:soul_space/features/phq9_assessment/presentation/screens/phq9_start_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Widget> pages = [
    HomeScreen(),
    Phq9StartScreen(),
    ArticleScreen(),
    GeminiScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.selectedIndex],
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }
}
