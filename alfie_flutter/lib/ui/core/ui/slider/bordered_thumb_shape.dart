import 'package:flutter/material.dart';

class BorderedRangeThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;

  const BorderedRangeThumbShape({
    this.thumbRadius = 12.0,
    this.fillColor = Colors.white,
    this.borderColor = Colors.black,
    this.borderWidth = 2.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(thumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr,
    Thumb thumb = Thumb.start,
    bool isPressed = false,
  }) {
    final Canvas canvas = context.canvas;

    // 1. Draw the black border (the larger circle)
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill; // Using fill for a crisp outer ring
    canvas.drawCircle(center, thumbRadius, borderPaint);

    // 2. Draw the white inner fill
    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius - borderWidth, fillPaint);
  }
}
