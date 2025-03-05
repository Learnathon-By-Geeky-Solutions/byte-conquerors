import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class GenderCard extends StatelessWidget {
  const GenderCard({
    super.key,
    required this.icon,
    required this.onTap,
    required this.text,
    required this.isSelected,
  });

  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.lightBackground,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: isSelected ? AppColors.lighFont : AppColors.primary,
                size: 26,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? AppColors.lighFont : AppColors.primary,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
