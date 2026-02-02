import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/checkbox_theme.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/input_field_theme.dart';
import 'package:alfie_flutter/ui/core/themes/size_unit.dart';
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
    iconTheme: IconThemeData(size: SizeUnit.m, color: AppColors.neutral800),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: AppColors.neutral800),
    ),

    checkboxTheme: ref.read(checkBoxThemeProvider),
    textTheme: ref.read(textThemeProvider),
    inputDecorationTheme: ref.read(inputDecoratiomThemeProvider),
    textSelectionTheme: ref.read(textSelectionThemeProvider),
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
