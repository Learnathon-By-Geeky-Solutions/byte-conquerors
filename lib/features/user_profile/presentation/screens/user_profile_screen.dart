import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_event.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                // Your other steps here
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _nextStep,
            child: Text(_currentStep < 3 ? 'Next' : 'Save'),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Pass the necessary userId (replace 'some_user_id' with actual data)
      context.read<UserProfileBloc>().add(SaveUserProfileEvent('some_user_id'));
    }
  }
}
