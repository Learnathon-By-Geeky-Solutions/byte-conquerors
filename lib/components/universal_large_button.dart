import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class UniversalLargeButton extends StatefulWidget {
  const UniversalLargeButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  final String buttonText;
  final VoidCallback? onTap;

  @override
  State<UniversalLargeButton> createState() => _UniversalLargeButtonState();
}

class _UniversalLargeButtonState extends State<UniversalLargeButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => widget.onTap!(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              height: 50.0,
              decoration: BoxDecoration(
                color: AppColors.primaryPurple,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    color: AppColors.fontWhite,
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
