import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Resolves the fill color of radio buttons based on their widget state.
///
/// Returns error color for validation errors, neutral disabled color
/// when disabled, and primary color for normal/selected states.
Color? _resolveRadioFillColor(Set<WidgetState> states) {
  if (states.contains(WidgetState.error)) {
    return AppColors.error500;
  }
  if (states.contains(WidgetState.disabled)) {
    return AppColors.neutral400;
  }
  return AppColors.neutral800;
}

/// Provides the [RadioThemeData] used throughout the application.
///
/// Configures consistent styling for radio buttons with state-aware
/// color changes for different interaction states.
final radioButtonThemeProvider = Provider<RadioThemeData>(
  (ref) => RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith(_resolveRadioFillColor),
  ),
);

/// Extension on [RadioThemeData] to provide helper methods for radio button styling.
extension RadioButtonThemeExtension on RadioThemeData {
  /// Returns the appropriate [TextStyle] for a radio button label.
  ///
  /// Applies bold weight when selected and adjusts color based on disabled state.
  /// Both selected and unselected labels use neutral colors, with disabled state
  /// always using the neutral disabled color.
  TextStyle getLabelStyle(
    BuildContext context,
    bool isDisabled,
    bool isSelected,
  ) {
    final textTheme = context.textTheme;
    final labelColor = isDisabled ? AppColors.neutral400 : AppColors.neutral800;
    final baseStyle = isSelected
        ? textTheme.bodyMediumBold!
        : textTheme.bodyMedium!;

    return baseStyle.copyWith(color: labelColor);
  }
}
