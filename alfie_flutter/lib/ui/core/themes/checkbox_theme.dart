import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkBoxThemeProvider = Provider<CheckboxThemeData>(
  (ref) => CheckboxThemeData(
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(0.0),
    ),

    // Fill of checkbox
    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.error)) {
        return AppColors.transparent;
      }
      if (states.contains(WidgetState.disabled)) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.neutral400;
        }
        return AppColors.transparent;
      }
      if (states.contains(WidgetState.selected)) {
        return AppColors.neutral800;
      }
      return Colors.transparent;
    }),

    // Border of checkbox
    side: WidgetStateBorderSide.resolveWith((states) {
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
    }),

    // Tick color of checkbox
    checkColor: WidgetStateProperty.all(AppColors.neutral),
  ),
);

extension CheckboxThemeExtension on CheckboxThemeData {
  TextStyle getLabelStyle(
    BuildContext context,
    bool isDisabled,
    bool? currentValue,
  ) {
    return (currentValue == true
            ? Theme.of(context).textTheme.bodyMediumBold
            : Theme.of(context).textTheme.bodyMedium)!
        .copyWith(
          color: isDisabled ? AppColors.neutral400 : AppColors.neutral800,
        );
  }

  TextStyle getInfoStyle(BuildContext context, bool isDisabled) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      color: isDisabled ? AppColors.neutral400 : AppColors.neutral500,
    );
  }
}
