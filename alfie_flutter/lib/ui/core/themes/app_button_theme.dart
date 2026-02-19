import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/icon_theme.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Button size options for responsive sizing.
enum ButtonSize { medium, small }

/// Visual styling variants for buttons with different semantic meanings.
enum ButtonVariant { primary, secondary, tertiary, destructive }

/// Provides the centralized button theme configuration for the application.
///
/// This provider creates theme styles for all button variants (primary, secondary,
/// tertiary, destructive) with consistent styling across the app. Each variant
/// has its own [ButtonStyle] with predefined colors, shapes, and states.
final appButtonThemeProvider = Provider<AppButtonTheme>(
  (ref) => AppButtonTheme(
    primary: _buildPrimaryStyle(ref),
    secondary: _buildSecondaryStyle(ref),
    tertiary: _buildTertiaryStyle(ref),
    destructive: _buildDestructiveStyle(ref),
  ),
);

// ─────────────────────────────────────────────────────────────────────────────
// Private Helper Functions for Button Styles
// ─────────────────────────────────────────────────────────────────────────────

/// Builds the primary button style: filled background with dark neutral color.
ButtonStyle _buildPrimaryStyle(Ref ref) =>
    ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      textStyle: ref.read(textThemeProvider).bodyMedium,
      backgroundColor: AppColors.neutral800,
      foregroundColor: AppColors.neutral,
      disabledBackgroundColor: AppColors.neutral300,
      disabledForegroundColor: AppColors.neutral500,
      iconSize: ref.read(iconThemeProvider).size,
    ).copyWith(
      side: WidgetStateProperty.resolveWith<BorderSide?>(
        (states) => states.contains(WidgetState.disabled)
            ? BorderSide(color: AppColors.neutral300)
            : BorderSide(color: AppColors.neutral800),
      ),
    );

/// Builds the secondary button style: outlined with dark neutral border.
ButtonStyle _buildSecondaryStyle(Ref ref) =>
    OutlinedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      textStyle: ref.read(textThemeProvider).bodyMedium,
      backgroundColor: AppColors.transparent,
      foregroundColor: AppColors.neutral800,
      disabledBackgroundColor: AppColors.transparent,
      disabledForegroundColor: AppColors.neutral500,
      iconSize: ref.read(iconThemeProvider).size,
    ).copyWith(
      side: WidgetStateProperty.resolveWith<BorderSide?>(
        (states) => states.contains(WidgetState.disabled)
            ? BorderSide(color: AppColors.neutral500)
            : BorderSide(color: AppColors.neutral800),
      ),
    );

/// Builds the tertiary button style: text-only with transparent background.
ButtonStyle _buildTertiaryStyle(Ref ref) => TextButton.styleFrom(
  elevation: 0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  textStyle: ref.read(textThemeProvider).bodyMedium,
  backgroundColor: AppColors.transparent,
  foregroundColor: AppColors.neutral800,
  disabledBackgroundColor: AppColors.transparent,
  disabledForegroundColor: AppColors.neutral500,
  iconSize: ref.read(iconThemeProvider).size,
);

/// Builds the destructive button style: filled with error color.
ButtonStyle _buildDestructiveStyle(Ref ref) =>
    ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      textStyle: ref.read(textThemeProvider).bodyMedium,
      backgroundColor: AppColors.error600,
      foregroundColor: AppColors.neutral,
      disabledBackgroundColor: AppColors.neutral300,
      disabledForegroundColor: AppColors.neutral500,
      iconSize: ref.read(iconThemeProvider).size,
    ).copyWith(
      side: WidgetStateProperty.resolveWith<BorderSide?>(
        (states) => states.contains(WidgetState.disabled)
            ? BorderSide(color: AppColors.neutral300)
            : BorderSide(color: AppColors.error600),
      ),
    );

// ─────────────────────────────────────────────────────────────────────────────
// AppButtonTheme Class
// ─────────────────────────────────────────────────────────────────────────────

/// Centralized theme extension providing button styles for all variants and sizes.
///
/// This class manages button styling through [ButtonStyle] properties, allowing
/// consistent theming across the application. Use [styleWith] to generate
/// size-specific and variant-specific button styles.
class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  final ButtonStyle? primary;
  final ButtonStyle? secondary;
  final ButtonStyle? tertiary;
  final ButtonStyle? destructive;

  const AppButtonTheme({
    this.primary,
    this.secondary,
    this.tertiary,
    this.destructive,
  });

  /// Generates a [ButtonStyle] for the given variant and size combination.
  ///
  /// Adjusts padding based on button size and whether it contains only an icon.
  /// Icon-only buttons receive less horizontal padding for visual balance.
  ///
  /// Parameters:
  ///   - [variant]: The semantic button type (primary, secondary, etc.)
  ///   - [size]: The button size (medium or small)
  ///   - [isIconOnly]: Whether the button contains only an icon (no text)
  ///
  /// Returns: A configured [ButtonStyle] ready for use in button widgets.
  ButtonStyle styleWith({
    required ButtonVariant variant,
    required ButtonSize size,
    required bool isIconOnly,
  }) {
    final baseStyle = switch (variant) {
      ButtonVariant.primary => primary,
      ButtonVariant.secondary => secondary,
      ButtonVariant.tertiary => tertiary,
      ButtonVariant.destructive => destructive,
    };

    final horizontalPaddingMultiplier = isIconOnly ? 1 : 2;

    final (
      EdgeInsetsGeometry padding,
      Size minSize,
      MaterialTapTargetSize tapTarget,
    ) = switch (size) {
      ButtonSize.medium => (
        EdgeInsets.symmetric(
          vertical: Spacing.extraSmall,
          horizontal: Spacing.extraSmall * horizontalPaddingMultiplier,
        ),
        const Size(0, 40),
        MaterialTapTargetSize.shrinkWrap,
      ),
      ButtonSize.small => (
        EdgeInsets.symmetric(
          vertical: Spacing.extraExtraSmall,
          horizontal: Spacing.extraExtraSmall * horizontalPaddingMultiplier,
        ),
        const Size(0, 32),
        MaterialTapTargetSize.shrinkWrap,
      ),
    };

    return baseStyle!.copyWith(
      padding: WidgetStatePropertyAll(padding),
      minimumSize: WidgetStatePropertyAll(minSize),
      tapTargetSize: tapTarget,
    );
  }

  @override
  AppButtonTheme copyWith({
    ButtonStyle? primary,
    ButtonStyle? secondary,
    ButtonStyle? tertiary,
    ButtonStyle? destructive,
  }) => AppButtonTheme(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    tertiary: tertiary ?? this.tertiary,
    destructive: destructive ?? this.destructive,
  );

  @override
  AppButtonTheme lerp(ThemeExtension<AppButtonTheme>? other, double t) {
    if (other is! AppButtonTheme) return this;
    return AppButtonTheme(
      primary: ButtonStyle.lerp(primary, other.primary, t),
      secondary: ButtonStyle.lerp(secondary, other.secondary, t),
      tertiary: ButtonStyle.lerp(tertiary, other.tertiary, t),
      destructive: ButtonStyle.lerp(destructive, other.destructive, t),
    );
  }
}
