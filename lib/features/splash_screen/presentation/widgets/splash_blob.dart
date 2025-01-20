import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soul_space/core/config/assets/app_vectors.dart';

class SplashBlob extends StatelessWidget {
  const SplashBlob({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    // final Size windowSize = MediaQuery.of(context).size;
    return SvgPicture.asset(
      AppVectors.splashBlob,
    ).animate().scale(
          delay: 500.ms,
          duration: 1000.ms,
          end: Offset(10, 10),
          curve: Curves.easeOut,
        );
  }
}
