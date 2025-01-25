import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class PageIndicatorDot extends StatelessWidget {
  const PageIndicatorDot({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  final dynamic index;
  final dynamic currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: currentIndex == index ? 30.0 : 10.0,
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: currentIndex == index
            ? AppColors.primaryPurple
            : AppColors.purpleAccent,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
