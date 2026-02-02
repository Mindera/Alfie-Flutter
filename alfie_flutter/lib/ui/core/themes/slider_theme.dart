import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/ui/slider/bordered_thumb_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sliderThemeProvider = Provider<SliderThemeData>(
  (ref) => SliderThemeData(
    activeTrackColor: AppColors.neutral800,
    inactiveTrackColor: AppColors.neutral400,
    rangeTrackShape: const RectangularRangeSliderTrackShape(),
    thumbColor: AppColors.neutral800,
    thumbSize: WidgetStateProperty.all(Size(24, 24)),
    rangeThumbShape: BorderedRangeThumbShape(
      thumbRadius: 12,
      fillColor: AppColors.neutral,
      borderColor: AppColors.neutral800,
      borderWidth: 2,
    ),
    trackHeight: 2,
    overlayColor: AppColors.neutral800.withValues(alpha: 0.2),
    valueIndicatorColor: AppColors.neutral800,
  ),
);
