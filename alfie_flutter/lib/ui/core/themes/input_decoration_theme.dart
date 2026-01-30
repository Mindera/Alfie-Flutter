import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inputDecoratiomThemeProvider = Provider<InputDecorationTheme>(
  (ref) => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.neutral,
    labelStyle: TextStyle(color: AppColors.neutral400),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacing.xxs),
      borderSide: BorderSide(color: AppColors.neutral200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacing.xxs),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacing.xxs),
      borderSide: BorderSide(color: Colors.grey),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacing.xxs),
      borderSide: BorderSide(color: Colors.red),
    ),
  ),
);
