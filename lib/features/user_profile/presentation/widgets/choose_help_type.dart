import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_state.dart';

class ChooseHelptypeStep extends StatelessWidget {
  const ChooseHelptypeStep();

  final _options = const [
    {"emoji": "😔", "text": "Tackling\nStress"},
    {"emoji": "😫", "text": "Overcoming\nDepression"},
    {"emoji": "😴", "text": "Better\nSleep"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("What can we help you with",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        ..._options
            .map((option) =>
                _buildOption(context, option['emoji']!, option['text']!))
            .toList(),
      ],
    );
  }

  Widget _buildOption(BuildContext context, String emoji, String label) {
    final bloc = context.read<UserProfileBloc>();
    return GestureDetector(
      onTap: () => bloc.add(UpdateHelpType(label)),
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          final selected =
              (state is UserProfileUpdated) && state.profile.helpType == label;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      color: selected ? Colors.white : AppColors.primary,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
