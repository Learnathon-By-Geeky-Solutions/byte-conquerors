import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soul_space/core/config/theme/assets/app_vectors.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppVectors.spotifyLogo);
  }
}
