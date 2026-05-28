import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Provides standardized factories for rendering application imagery.
abstract class ImageFactory {
  static const Image fallbackImage = Image(
    image: AssetImage('assets/images/fallback_image.png'),
    fit: BoxFit.cover,
  );

  /// Loads a remote image from the specified [url] with a built-in fallback state.
  ///
  /// Utilizes [FadeInImage.assetNetwork] to transition smoothly from a local
  /// placeholder to the downloaded asset. Renders the placeholder indefinitely
  /// if the [url] is malformed or inaccessible.
  static Widget network(String url) {
    if (url.isEmpty) {
      return fallbackImage;
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final double dpr = context.mediaQuery.devicePixelRatio;

        final int? targetWidth =
            constraints.maxWidth.isFinite && constraints.maxWidth > 0
            ? (constraints.maxWidth * dpr).round()
            : null;

        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,

          memCacheWidth: targetWidth,

          placeholder: (context, url) => fallbackImage,
          errorWidget: (context, url, error) => fallbackImage,
        );
      },
    );
  }

  /// Renders a remote image overlaid with a dark vertical gradient.
  ///
  /// Primarily used for featured content where high-contrast [foreground] text
  /// must remain legible against unpredictable image backgrounds.
  static Stack networkWithGradient(
    String url, {
    Widget? foreground,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: Spacing.small,
      vertical: Spacing.extraExtraLarge - 2,
    ),
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        network(url),
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.neutral800],
                ),
              ),
            ),
          ),
        ),
        if (foreground != null) ...[
          Padding(
            padding: padding,
            child: Align(alignment: Alignment.bottomLeft, child: foreground),
          ),
        ],
      ],
    );
  }
}
