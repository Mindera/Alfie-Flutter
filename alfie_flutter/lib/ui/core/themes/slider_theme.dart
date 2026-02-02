import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/ui/slider/bordered_thumb_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Slider dimensions
const double _thumbRadius = 12;
const double _trackHeight = 2;
const double _thumbBorderWidth = 2;

// Slider overlay opacity
const double _overlayAlpha = 0.2;

/// Provides the [SliderThemeData] used throughout the application.
///
/// Configures consistent styling for slider components including:
/// - Track colors for active and inactive states
/// - Thumb size and custom bordered appearance
/// - Track dimensions and overlay styling
final sliderThemeProvider = Provider<SliderThemeData>(
  (ref) => SliderThemeData(
    activeTrackColor: AppColors.neutral800,
    inactiveTrackColor: AppColors.neutral400,
    rangeTrackShape: const RectangularRangeSliderTrackShape(),
    thumbColor: AppColors.neutral800,
    rangeThumbShape: BorderedRangeThumbShape(
      thumbRadius: _thumbRadius,
      fillColor: AppColors.neutral,
      borderColor: AppColors.neutral800,
      borderWidth: _thumbBorderWidth,
    ),
    trackHeight: _trackHeight,
    overlayColor: AppColors.neutral800.withValues(alpha: _overlayAlpha),
    valueIndicatorColor: AppColors.neutral800,
  ),
);
