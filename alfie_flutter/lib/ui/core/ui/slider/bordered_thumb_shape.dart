import 'package:flutter/material.dart';

/// A custom range slider thumb shape with a border and fill.
///
/// [BorderedRangeThumbShape] renders a circular thumb with a configurable
/// border and inner fill, allowing styling that aligns
/// with the design system.
///
/// The thumb is drawn as two concentric circles:
/// - Outer circle: border color at [thumbRadius]
/// - Inner circle: fill color at `[thumbRadius] - [borderWidth]`
class BorderedRangeThumbShape extends RangeSliderThumbShape {
  /// The radius of the thumb's outer boundary (including border).
  final double thumbRadius;

  /// The color of the thumb's inner fill.
  final Color fillColor;

  /// The color of the thumb's outer border.
  final Color borderColor;

  /// The width of the border ring in logical pixels.
  ///
  /// This value is subtracted from [thumbRadius] to determine the
  /// radius of the inner fill circle.
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

  /// Paints the bordered thumb as two concentric circles.
  ///
  /// The outer circle (border) is drawn at [thumbRadius], and the inner
  /// circle (fill) is drawn at `[thumbRadius] - [borderWidth]`, creating
  /// a ring effect. Both use fill style for crisp, solid rendering.
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

    // Draw outer border circle
    canvas.drawCircle(
      center,
      thumbRadius,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.fill,
    );

    // Draw inner fill circle
    canvas.drawCircle(
      center,
      thumbRadius - borderWidth,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill,
    );
  }
}
