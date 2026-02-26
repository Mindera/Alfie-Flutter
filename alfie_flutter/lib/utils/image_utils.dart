import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

abstract class ImageFactory {
  static Widget network(String url) {
    if (url.isEmpty) {
      return Image.asset(
        'assets/images/fallback_image.png',
        fit: BoxFit.fitHeight,
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) => FadeInImage.assetNetwork(
        imageCacheHeight: constraints.maxHeight.isFinite
            ? constraints.maxHeight.toInt()
            : null,
        placeholder: 'assets/images/fallback_image.png',
        image: url,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/fallback_image.png',
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

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
