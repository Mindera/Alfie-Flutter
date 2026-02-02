import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconSizes {
  static double small = 16;
  static double medium = 24;
  static double large = 32;
}

final iconThemeProvider = Provider<IconThemeData>((ref) {
  return IconThemeData(size: IconSizes.medium, color: AppColors.neutral800);
});

final iconButtonThemeProvider = Provider<IconButtonThemeData>((ref) {
  return IconButtonThemeData(
    style: IconButton.styleFrom(foregroundColor: AppColors.neutral800),
  );
});
