import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Consistent border radius for all input field states
final _inputBorderRadius = BorderRadius.circular(Spacing.extraExtraSmall);

// Neutral border color for normal and focused states
final _inputBorderColor = BorderSide(color: AppColors.neutral200);

// Error border color for validation error state
final _errorBorderColor = BorderSide(color: AppColors.error700);

/// Provides the [InputDecorationTheme] used throughout the application.
///
/// Configures consistent styling for text input fields including:
/// - Border styling for all states (normal, focused, enabled, error)
/// - Icon colors and positioning
/// - Hint text styling
final inputDecorationThemeProvider = Provider<InputDecorationTheme>(
  (ref) => InputDecorationTheme(
    filled: true,
    suffixIconColor: AppColors.neutral800,
    prefixIconColor: AppColors.neutral800,
    iconColor: AppColors.neutral800,
    hintStyle: ref
        .read(textThemeProvider)
        .bodyMedium!
        .copyWith(color: AppColors.neutral400),
    border: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: _inputBorderColor,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: _inputBorderColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: _inputBorderColor,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: _errorBorderColor,
    ),
  ),
);

/// Provides the [TextSelectionThemeData] for text selection styling.
///
/// Configures the appearance of selected text, cursor, and selection handles
/// to maintain consistent visual feedback across text input interactions.
final textSelectionThemeProvider = Provider<TextSelectionThemeData>(
  (ref) => TextSelectionThemeData(
    cursorColor: AppColors.neutral800,
    selectionColor: AppColors.neutral300,
    selectionHandleColor: AppColors.neutral600,
  ),
);
