import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class SplashBlob extends StatelessWidget {
  const SplashBlob({super.key});

  @override
  Widget build(BuildContext context) {
    return Blob.fromID(
      id: ['3-7-742289'],
      size: 400,
      styles: BlobStyles(
        color: AppColors.primaryGreen,
      ),
    );
  }
}
