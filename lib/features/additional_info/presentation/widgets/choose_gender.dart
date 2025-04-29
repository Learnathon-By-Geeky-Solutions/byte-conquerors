import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class ChooseGender extends StatefulWidget {
  @override
  _ChooseGenderState createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  String selectedGender = 'Male'; // default selected

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Choose your\ngender',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGenderOption(
              gender: 'Male',
              emoji: '🧔',
              isSelected: selectedGender == 'Male',
            ),
            const SizedBox(width: 20),
            _buildGenderOption(
              gender: 'Female',
              emoji: '👩',
              isSelected: selectedGender == 'Female',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required String gender,
    required String emoji,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 10),
            Text(
              gender,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
