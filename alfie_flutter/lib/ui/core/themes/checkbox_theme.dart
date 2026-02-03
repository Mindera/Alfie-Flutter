import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the centralized checkbox theme configuration for the application.
///
/// Defines visual styles for checkboxes in all states: default, selected,
/// disabled, and error. The theme ensures consistency across the app and
/// provides semantic color feedback for user interactions.
final checkBoxThemeProvider = Provider<CheckboxThemeData>(
  (ref) => CheckboxThemeData(
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
    fillColor: _resolveFillColor(),
    side: _resolveBorderSide(),
    checkColor: WidgetStateProperty.all(AppColors.neutral),
  ),
);

// ─────────────────────────────────────────────────────────────────────────────
// Private Helper Functions
// ─────────────────────────────────────────────────────────────────────────────

/// Resolves checkbox fill color based on widget state.
///
/// States are evaluated in order of precedence:
///   - Error: transparent (shows error border instead)
///   - Disabled + Selected: light neutral (disabled checked state)
///   - Disabled (unselected): transparent (disabled unchecked state)
///   - Selected: dark neutral (checked state)
///   - Default: transparent (unchecked state)
WidgetStateProperty<Color> _resolveFillColor() =>
    WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.error)) {
        return AppColors.transparent;
      }
      if (states.contains(WidgetState.disabled)) {
        return states.contains(WidgetState.selected)
            ? AppColors.neutral400
            : AppColors.transparent;
      }
      if (states.contains(WidgetState.selected)) {
        return AppColors.neutral800;
      }
      return Colors.transparent;
    });

/// Resolves checkbox border based on widget state.
///
/// States are evaluated in order of precedence:
///   - Error: red border (indicates validation error)
///   - Selected: no border (filled state doesn't need border)
///   - Disabled: light neutral border
///   - Default: dark neutral border
WidgetStateBorderSide _resolveBorderSide() =>
    WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.error)) {
        return BorderSide(color: AppColors.error400, width: 1);
      }
      if (states.contains(WidgetState.selected)) {
        return BorderSide.none;
      }
      if (states.contains(WidgetState.disabled)) {
        return BorderSide(color: AppColors.neutral400, width: 1);
      }
      return BorderSide(color: AppColors.neutral800, width: 1);
    });

// ─────────────────────────────────────────────────────────────────────────────
// CheckboxThemeExtension
// ─────────────────────────────────────────────────────────────────────────────

/// Extension providing text styling utilities for checkbox labels and helper text.
///
/// Dynamically applies typography and color based on checkbox state to ensure
/// visual consistency and clear semantic feedback (e.g., gray text for disabled).
extension CheckboxThemeExtension on CheckboxThemeData {
  /// Returns the text style for checkbox labels based on state.
  ///
  /// Applies bold typography when the checkbox is selected to provide
  /// visual emphasis. Disables text when the checkbox is disabled.
  ///
  /// Parameters:
  ///   - [context]: Build context for accessing theme data
  ///   - [isDisabled]: Whether the checkbox is currently disabled
  ///   - [currentValue]: The current checked state (null, true, or false)
  ///
  /// Returns: A [TextStyle] with appropriate weight and color.
  TextStyle getLabelStyle(
    BuildContext context,
    bool isDisabled,
    bool? currentValue,
  ) =>
      (currentValue == true
              ? Theme.of(context).textTheme.bodyMediumBold
              : Theme.of(context).textTheme.bodyMedium)!
          .copyWith(
            color: isDisabled ? AppColors.neutral400 : AppColors.neutral800,
          );

  /// Returns the text style for checkbox helper/info text based on state.
  ///
  /// Uses a smaller text size with reduced color emphasis for secondary information.
  /// Disables text when the checkbox is disabled.
  ///
  /// Parameters:
  ///   - [context]: Build context for accessing theme data
  ///   - [isDisabled]: Whether the checkbox is currently disabled
  ///
  /// Returns: A [TextStyle] with reduced emphasis appropriate for helper text.
  TextStyle getInfoStyle(BuildContext context, bool isDisabled) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
        color: isDisabled ? AppColors.neutral400 : AppColors.neutral500,
      );
}
