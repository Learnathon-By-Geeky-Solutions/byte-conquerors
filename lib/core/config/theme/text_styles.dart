import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_size.dart';

abstract class TextStyles {
  static TextStyle headlineMedium = TextStyle(
    fontSize: AppSize.f26,
    fontWeight: FontWeight.w500,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: AppSize.f16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleLarge = TextStyle(
    fontSize: AppSize.f20,
    fontWeight: FontWeight.w400,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: AppSize.f14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle titleSmall = TextStyle(
    fontSize: AppSize.f12,
    fontWeight: FontWeight.w400,
  );
}
