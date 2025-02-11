import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(14),
        child: Icon(
          icon,
          color: AppColors.lighFont,
          size: 20,
        ),
      ),
    );
  }
}
