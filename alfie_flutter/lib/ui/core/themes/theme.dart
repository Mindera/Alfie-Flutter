import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/input_decoration_theme.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.neutral800,
    colorScheme: ColorScheme.light(primary: AppColors.neutral800),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.neutral800,
    ),

    textTheme: ref.read(textThemeProvider),
    inputDecorationTheme: ref.read(inputDecoratiomThemeProvider),
    extensions: [ref.read(appButtonThemeProvider)],
  );
});

final darkThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    brightness: Brightness.dark,
    textTheme: ref.read(textThemeProvider),

    extensions: [ref.read(appButtonThemeProvider)],
  );
});
