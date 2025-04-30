import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_state.dart';

class ChooseGenderStep extends StatelessWidget {
  const ChooseGenderStep();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserProfileBloc>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Choose your gender',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOption(context, '🧔', 'Male', bloc),
            const SizedBox(width: 20),
            _buildOption(context, '👩', 'Female', bloc),
          ],
        ),
      ],
    );
  }

  Widget _buildOption(
      BuildContext context, String emoji, String label, UserProfileBloc bloc) {
    return GestureDetector(
      onTap: () => bloc.add(UpdateGender(label)),
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          final selected =
              (state is UserProfileUpdated) && state.profile.gender == label;
          return Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 10),
                Text(label,
                    style: TextStyle(
                        color: selected ? Colors.white : Colors.grey[700])),
              ],
            ),
          );
        },
      ),
    );
  }
}
