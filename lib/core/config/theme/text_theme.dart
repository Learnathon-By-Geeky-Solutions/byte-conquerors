import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/core/config/theme/text_styles.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static TextTheme lightText = TextTheme(
    headlineMedium: TextStyles.headlineMedium.copyWith(
      color: AppColors.darkFont,
    ),
    labelMedium: TextStyles.labelMedium.copyWith(
      color: AppColors.darkFont,
    ),
    titleLarge: TextStyles.titleLarge.copyWith(
      color: AppColors.darkFont,
    ),
    titleMedium: TextStyles.titleMedium.copyWith(
      color: AppColors.darkFont,
    ),
    titleSmall: TextStyles.titleSmall.copyWith(
      color: AppColors.darkFont,
    ),
  );
  static TextTheme darkText = TextTheme(
    headlineMedium: TextStyles.headlineMedium.copyWith(
      color: AppColors.lighFont,
    ),
    labelMedium: TextStyles.labelMedium.copyWith(
      color: AppColors.lighFont,
    ),
    titleLarge: TextStyles.titleLarge.copyWith(
      color: AppColors.lighFont,
    ),
    titleMedium: TextStyles.titleMedium.copyWith(
      color: AppColors.lighFont,
    ),
    titleSmall: TextStyles.titleSmall.copyWith(
      color: AppColors.lighFont,
    ),
  );
}
