import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ButtonSize { medium, small }

enum ButtonVariant { primary, secondary, tertiary, destructive }

final appButtonThemeProvider = Provider<AppButtonTheme>(
  (ref) => AppButtonTheme(
    primary:
        ElevatedButton.styleFrom(
          elevation: 0,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: ref.read(textThemeProvider).bodyMedium,

          // Defaults
          backgroundColor: AppColors.neutral800,
          foregroundColor: AppColors.neutral,

          // Disabled
          disabledBackgroundColor: AppColors.neutral300,
          disabledForegroundColor: AppColors.neutral500,
        ).copyWith(
          side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: AppColors.neutral300); // Disabled border
            }
            return BorderSide(color: AppColors.neutral800); // Default border
          }),
        ),
    secondary:
        OutlinedButton.styleFrom(
          elevation: 0,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),

          textStyle: ref.read(textThemeProvider).bodyMedium,

          // Default
          backgroundColor: AppColors.transparent,
          foregroundColor: AppColors.neutral800,

          // Disabled
          disabledBackgroundColor: AppColors.transparent,
          disabledForegroundColor: AppColors.neutral500,
        ).copyWith(
          side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: AppColors.neutral500); // Disabled border
            }
            return BorderSide(color: AppColors.neutral800); // Default border
          }),
        ),
    tertiary: TextButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      textStyle: ref.read(textThemeProvider).bodyMedium,

      // Defaults
      backgroundColor: AppColors.transparent,
      foregroundColor: AppColors.neutral800,

      // Disabled
      disabledBackgroundColor: AppColors.transparent,
      disabledForegroundColor: AppColors.neutral500,
    ),
    destructive:
        ElevatedButton.styleFrom(
          elevation: 0,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: ref.read(textThemeProvider).bodyMedium,

          // Defaults
          backgroundColor: AppColors.error600,
          foregroundColor: AppColors.neutral,

          // Disabled
          disabledBackgroundColor: AppColors.neutral300,
          disabledForegroundColor: AppColors.neutral500,
        ).copyWith(
          side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: AppColors.neutral300); // Disabled border
            }
            return BorderSide(color: AppColors.error600); // Default border
          }),
        ),
  ),
);

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

  /// This is your custom "copyWith" logic for sizes
  ButtonStyle styleWith({
    required ButtonVariant variant,
    required ButtonSize size,
    required bool isIconOnly,
  }) {
    // 1. Get the base style
    final baseStyle = switch (variant) {
      ButtonVariant.primary => primary,
      ButtonVariant.secondary => secondary,
      ButtonVariant.tertiary => tertiary,
      ButtonVariant.destructive => destructive,
    };

    final horizontalPaddingMultiplier = isIconOnly ? 1 : 2;

    // 2. Define Padding AND Constraints based on size
    final (
      EdgeInsetsGeometry padding,
      Size minSize,
      MaterialTapTargetSize tapTarget,
    ) = switch (size) {
      ButtonSize.medium => (
        EdgeInsets.symmetric(
          vertical: Spacing.xs,
          horizontal: Spacing.xs * horizontalPaddingMultiplier,
        ),
        const Size(0, 40), // Standard Material height
        MaterialTapTargetSize.padded,
      ),
      ButtonSize.small => (
        EdgeInsets.symmetric(
          vertical: Spacing.xxs,
          horizontal: Spacing.xxs * horizontalPaddingMultiplier,
        ),
        const Size(0, 32), // Allow shrinking down to 32px (or 0 to fit content)
        MaterialTapTargetSize.padded, // Removes extra touch-target spacing
      ),
    };

    // 3. Merge everything
    // Note: We use ! because we assume baseStyle is defined in your theme setup
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
  }) {
    return AppButtonTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      destructive: destructive ?? this.destructive,
    );
  }

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
