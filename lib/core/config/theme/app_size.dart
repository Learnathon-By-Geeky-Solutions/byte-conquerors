import 'package:flutter/material.dart';

class AppSize {
  static late double width;
  static late double height;

  static void init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  static double w(double percent) {
    return width * (percent / 100);
  }

  static double h(double percent) {
    return height * (percent / 100);
  }

  static double get xs => w(2);

  static double get sm => w(4);

  static double get md => w(8);

  static double get lg => w(16);

  static double get xl => w(24);

  static double get f12 => w(3);

  static double get f14 => w(3.5);

  static double get f16 => w(4);

  static double get f18 => w(4.5);

  static double get f20 => w(5);

  static double get f26 => w(6);
}
