import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/checkbox_theme.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/icon_theme.dart';
import 'package:alfie_flutter/ui/core/themes/input_field_theme.dart';
import 'package:alfie_flutter/ui/core/themes/radio_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/slider_theme.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the light [ThemeData] for the application.
///
/// Composes all component-specific theme configurations (input fields, buttons,
/// checkboxes, etc.) into a cohesive light theme with consistent colors and typography.
final themeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.neutral800,
    colorScheme: ColorScheme.light(primary: AppColors.neutral800),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.neutral800,
    ),

    // Component themes
    radioTheme: ref.read(radioButtonThemeProvider),
    sliderTheme: ref.read(sliderThemeProvider),
    iconTheme: ref.read(iconThemeProvider),
    iconButtonTheme: ref.read(iconButtonThemeProvider),
    checkboxTheme: ref.read(checkBoxThemeProvider),

    // Text and input themes
    textTheme: ref.read(textThemeProvider),
    inputDecorationTheme: ref.read(inputDecorationThemeProvider),
    textSelectionTheme: ref.read(textSelectionThemeProvider),

    // Custom extensions
    extensions: [ref.read(appButtonThemeProvider)],
  );
});

/// Provides the dark [ThemeData] for the application.
///
/// Currently not implemented. Can be configured here as
/// the dark theme is further developed.
final darkThemeProvider = Provider<ThemeData>((ref) {
  throw UnimplementedError();
});
