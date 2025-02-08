import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class UniversalLargeButton extends StatelessWidget {
  const UniversalLargeButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  final String buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onTap!(),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: AppColors.lighFont,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
