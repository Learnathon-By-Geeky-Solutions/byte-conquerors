import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/application/navigation/bloc/navigation_bloc.dart';
import 'package:soul_space/application/navigation/bloc/navigation_event.dart';
import 'package:soul_space/application/navigation/bloc/navigation_state.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.selectedIndex,
          onTap: (index) =>
              context.read<NavigationBloc>().add(NavigateTo(index)),
          backgroundColor: const Color(0xFFEDE6F2),
          selectedItemColor: const Color(0xFF4B2E5D),
          unselectedItemColor: const Color(0xFF836D8F),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.self_improvement),
              label: 'Assess',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Journal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}
