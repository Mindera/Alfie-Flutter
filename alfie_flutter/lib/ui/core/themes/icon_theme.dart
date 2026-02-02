import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Icon Sizes
// ─────────────────────────────────────────────────────────────────────────────

/// Defines standardized icon sizes used consistently across the application.
///
/// Using a single source of truth for sizes ensures visual cohesion and makes
/// it easier to adjust sizing globally if design requirements change.
class IconSizes {
  const IconSizes._();

  /// Standard medium icon size (24dp) for general UI icons.
  static const double medium = 24;
}

// ─────────────────────────────────────────────────────────────────────────────
// Icon Theme Providers
// ─────────────────────────────────────────────────────────────────────────────

/// Provides the default icon theme for the application.
///
/// Defines the default size and color for all icons used in the app,
/// ensuring visual consistency across different screens and components.
final iconThemeProvider = Provider<IconThemeData>(
  (ref) => IconThemeData(size: IconSizes.medium, color: AppColors.neutral800),
);

/// Provides the icon button theme for the application.
///
/// Configures icon buttons with a standard size ([IconSizes.medium]) and
/// foreground color ([AppColors.neutral800]). This ensures all icon buttons
/// have consistent appearance and are easily adjustable from a single source.
final iconButtonThemeProvider = Provider<IconButtonThemeData>(
  (ref) => IconButtonThemeData(
    style: IconButton.styleFrom(
      iconSize: IconSizes.medium,
      foregroundColor: AppColors.neutral800,
    ),
  ),
);
