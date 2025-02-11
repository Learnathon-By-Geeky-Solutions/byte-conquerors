import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/profile/presentation/widgets/gender_card.dart';

class ChooseGender extends StatefulWidget {
  const ChooseGender({super.key});

  @override
  State<ChooseGender> createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  String selectedGender = 'male';

  void toggleGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Choose your gender",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              GenderCard(
                isSelected: selectedGender == 'male',
                text: 'MALE',
                icon: Icons.male,
                onTap: () => toggleGender('male'),
              ),
              SizedBox(
                width: 10,
              ),
              GenderCard(
                isSelected: selectedGender == 'female',
                text: 'Female',
                icon: Icons.male,
                onTap: () => toggleGender('female'),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
