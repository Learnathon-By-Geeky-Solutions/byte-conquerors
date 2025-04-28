/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/nav_chat_selected.svg
  String get navChatSelected => 'assets/icons/nav_chat_selected.svg';

  /// File path: assets/icons/nav_home_selected.svg
  String get navHomeSelected => 'assets/icons/nav_home_selected.svg';

  /// File path: assets/icons/nav_home_unselected.svg
  String get navHomeUnselected => 'assets/icons/nav_home_unselected.svg';

  /// File path: assets/icons/nav_news_selected.svg
  String get navNewsSelected => 'assets/icons/nav_news_selected.svg';

  /// File path: assets/icons/nav_news_unselected.svg
  String get navNewsUnselected => 'assets/icons/nav_news_unselected.svg';

  /// File path: assets/icons/nav_profile_selected.svg
  String get navProfileSelected => 'assets/icons/nav_profile_selected.svg';

  /// File path: assets/icons/nav_profile_unselected.svg
  String get navProfileUnselected => 'assets/icons/nav_profile_unselected.svg';

  /// List of all assets
  List<String> get values => [
        navChatSelected,
        navHomeSelected,
        navHomeUnselected,
        navNewsSelected,
        navNewsUnselected,
        navProfileSelected,
        navProfileUnselected,
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/icon-logo-light.png
  AssetGenImage get iconLogoLight =>
      const AssetGenImage('assets/images/icon-logo-light.png');

  /// File path: assets/images/icon-logo-primary.png
  AssetGenImage get iconLogoPrimary =>
      const AssetGenImage('assets/images/icon-logo-primary.png');

  /// File path: assets/images/logo-light.png
  AssetGenImage get logoLight =>
      const AssetGenImage('assets/images/logo-light.png');

  /// File path: assets/images/logo-primary.png
  AssetGenImage get logoPrimary =>
      const AssetGenImage('assets/images/logo-primary.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        iconLogoLight,
        iconLogoPrimary,
        logoLight,
        logoPrimary,
      ];
}

class $AssetsVectorsGen {
  const $AssetsVectorsGen();

  /// File path: assets/vectors/hero-background.svg
  String get heroBackground => 'assets/vectors/hero-background.svg';

  /// File path: assets/vectors/logo-black.svg
  String get logoBlack => 'assets/vectors/logo-black.svg';

  /// File path: assets/vectors/logo-purple.svg
  String get logoPurple => 'assets/vectors/logo-purple.svg';

  /// File path: assets/vectors/logo-white.svg
  String get logoWhite => 'assets/vectors/logo-white.svg';

  /// File path: assets/vectors/sapiens-cycling.svg
  String get sapiensCycling => 'assets/vectors/sapiens-cycling.svg';

  /// File path: assets/vectors/sapiens-running.svg
  String get sapiensRunning => 'assets/vectors/sapiens-running.svg';

  /// File path: assets/vectors/sapiens-standing.svg
  String get sapiensStanding => 'assets/vectors/sapiens-standing.svg';

  /// File path: assets/vectors/splash-blob.svg
  String get splashBlob => 'assets/vectors/splash-blob.svg';

  /// List of all assets
  List<String> get values => [
        heroBackground,
        logoBlack,
        logoPurple,
        logoWhite,
        sapiensCycling,
        sapiensRunning,
        sapiensStanding,
        splashBlob,
      ];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsVectorsGen vectors = $AssetsVectorsGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
