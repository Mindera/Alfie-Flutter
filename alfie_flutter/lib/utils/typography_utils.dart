import 'package:flutter/material.dart';

extension TypographyUtils on TextStyle {
  double get textHeight {
    if (height == null || fontSize == null) {
      throw Exception("Height and font size are not defined for this: $this");
    }
    return height! * fontSize!;
  }
}
