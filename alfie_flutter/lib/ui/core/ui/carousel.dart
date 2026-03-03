import 'package:flutter/material.dart';

/// A horizontally scrollable carousel that constrains its maximum height.
///
/// Designed as a reusable UI component, it wraps Flutter's
/// native [CarouselView] to enforce height constraints and standardized item spacing.
class Carousel extends StatelessWidget {
  /// The maximum vertical space the carousel is allowed to occupy.
  final double maxHeight;

  /// The padding applied to the right side of the carousel items.
  final double itemSpacing;

  /// The main axis extent (width) of each fully visible child item.
  final double itemExtent;

  /// The target extent items shrink to as they scroll out of the viewport.
  final double shrinkExtent;

  final List<Widget> children;

  const Carousel({
    super.key,
    required this.maxHeight,
    required this.itemSpacing,
    required this.itemExtent,
    this.shrinkExtent = 0.0,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: CarouselView(
        padding: EdgeInsets.only(right: itemSpacing),
        itemSnapping: true,
        shape: const RoundedRectangleBorder(),
        itemExtent: itemExtent,
        shrinkExtent: shrinkExtent,
        children: children,
      ),
    );
  }
}
