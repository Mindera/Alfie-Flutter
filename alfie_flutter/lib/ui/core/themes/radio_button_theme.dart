import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final radioButtonThemeProvider = Provider<RadioThemeData>(
  (ref) => RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.error)) {
        return AppColors.error500;
      }
      if (states.contains(WidgetState.disabled)) {
        return AppColors.neutral400;
      }
      return AppColors.neutral800;
    }),
  ),
);

extension RadioButtonThemeExtension on RadioThemeData {
  TextStyle getLabelStyle(
    BuildContext context,
    bool isDisabled,
    bool isSelected,
  ) {
    if (isSelected) {
      return Theme.of(context).textTheme.bodyMediumBold!.copyWith(
        color: isDisabled ? AppColors.neutral400 : AppColors.neutral800,
      );
    }

    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: isDisabled ? AppColors.neutral400 : AppColors.neutral800,
    );
  }
}
