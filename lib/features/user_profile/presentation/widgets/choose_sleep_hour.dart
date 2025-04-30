import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:soul_space/features/user_profile/presentation/bloc/user_profile_event.dart';

class ChooseSleephourStep extends StatefulWidget {
  const ChooseSleephourStep();

  @override
  State<ChooseSleephourStep> createState() => ChooseSleephourStepState();
}

class ChooseSleephourStepState extends State<ChooseSleephourStep> {
  int selectedHour = 8;

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(UpdateSleepHour(selectedHour));
  }

  @override
  Widget build(BuildContext context) {
    final List<int> hours = List.generate(18, (i) => i + 1);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('How many hours do you sleep?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: hours.map((h) {
            final isSelected = h == selectedHour;
            return GestureDetector(
              onTap: () {
                setState(() => selectedHour = h);
                context.read<UserProfileBloc>().add(UpdateSleepHour(h));
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$h",
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
