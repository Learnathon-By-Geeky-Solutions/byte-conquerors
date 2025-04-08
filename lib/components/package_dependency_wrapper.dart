import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Wrapper {
  Wrapper._();

  /// For SVG image
  static Widget setSVGImage({
    required String imagePath,
    double? height,
    double? width,
    ColorFilter? colorFilter,
    Size? size,
    BoxFit fit = BoxFit.cover,
  }) {
    return SvgPicture.asset(
      imagePath,
      height: size?.height ?? height,
      width: size?.width ?? width,
      colorFilter: colorFilter,
      fit: fit,
    );
  }

  /// For Cached Network image
  static Widget setCachedNetworkImage({
    required String imageUrl,
    double? width,
    double? height,
    double? radiusCircular,
    BoxFit fit = BoxFit.cover,
    Color placeholderColor = Colors.grey,
    IconData errorIcon = Icons.image,
  }) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, __) => setShimmerEffect(
          height: height, width: width, radiusCircular: radiusCircular),
      imageUrl: imageUrl,
      errorWidget: (_, __, ___) => Icon(errorIcon),
    );
  }

  /// For Shimmer effect
  static Widget setShimmerEffect({
    double? width,
    double? height,
    double? radiusCircular,
    Color placeholderColor = Colors.grey,
  }) {
    return Shimmer.fromColors(
      baseColor: placeholderColor,
      highlightColor: AppColors.foundationWhite,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusCircular ?? 0),
        child: Container(
          width: width ?? 17.w,
          height: height ?? 4.h,
          color: placeholderColor,
        ),
      ),
    );
  }

  /// For URL launcher
  static Future<void> launchRelevantApp({required Uri url}) async {
    if (!await launchUrl(url,
        mode: Platform.isIOS
            ? LaunchMode.externalApplication
            : LaunchMode.externalNonBrowserApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  /// For Rating bar
  static Widget buildRatingBar({
    required Function(double) onRatingUpdate,
    double initialRating = 0,
    double minRating = 0,
    int itemCount = 5,
    bool allowHalfRating = false,
    Axis direction = Axis.horizontal,
    required double iconSize,
    bool ignoreGestures = false,
    bool isGlow = false,
    Color? unratedColor,
    required String ratingIconPath,
  }) {
    return RatingBar.builder(
      glow: isGlow,
      unratedColor: unratedColor ?? AppColors.neutralColor.shade200,
      ignoreGestures: ignoreGestures,
      itemSize: iconSize,
      initialRating: initialRating,
      minRating: minRating,
      direction: direction,
      allowHalfRating: allowHalfRating,
      itemCount: itemCount,
      itemBuilder: (context, _) => setSVGImage(imagePath: ratingIconPath),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
