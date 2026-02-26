import 'package:flutter/material.dart';

extension TypographyUtils on TextStyle {
  double? get textHeight {
    if (height == null || fontSize == null) return null;
    return height! * fontSize!;
  }
}
