import 'package:flutter/material.dart';

/// Provides measurement utility extensions for [TextStyle] evaluation.
extension TypographyUtils on TextStyle {
  /// Calculates the absolute pixel height of the text based on its [height] multiplier and [fontSize].
  ///
  /// Returns a safe fallback of `0.0` if styling metrics are undefined.
  double get textHeight {
    if (height == null || fontSize == null) {
      return 0.0;
    }
    return height! * fontSize!;
  }
}
