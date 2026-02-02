import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inputDecoratiomThemeProvider = Provider<InputDecorationTheme>(
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
      borderRadius: BorderRadius.circular(Spacing.extraExtraSmall),
      borderSide: BorderSide(color: AppColors.neutral200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacing.extraExtraSmall),
      borderSide: BorderSide(color: AppColors.neutral200),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacing.extraExtraSmall),
      borderSide: BorderSide(color: AppColors.neutral200),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacing.extraExtraSmall),
      borderSide: BorderSide(color: AppColors.error700),
    ),
  ),
);

final textSelectionThemeProvider = Provider<TextSelectionThemeData>(
  (ref) => TextSelectionThemeData(
    cursorColor: AppColors.neutral800,
    selectionColor: AppColors.neutral300,
    selectionHandleColor: AppColors.neutral600,
  ),
);
