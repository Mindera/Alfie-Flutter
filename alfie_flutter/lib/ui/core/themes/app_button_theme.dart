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

    final horizontalPaddingMultiplier = isIconOnly
        ? 1
        : 2; // Less padding for icon-only buttons

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
        const Size(0, 40), // Standard Material height
        MaterialTapTargetSize.padded,
      ),
      ButtonSize.small => (
        EdgeInsets.symmetric(
          vertical: Spacing.extraExtraSmall,
          horizontal: Spacing.extraExtraSmall * horizontalPaddingMultiplier,
        ),
        const Size(0, 32),
        MaterialTapTargetSize.padded, // Removes extra touch-target spacing
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
