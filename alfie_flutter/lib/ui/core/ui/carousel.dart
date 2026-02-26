import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Carousel extends HookWidget {
  final double maxHeight;
  final double itemSpacing;
  final double itemExtent;
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
        shape: RoundedRectangleBorder(),
        itemExtent: itemExtent,
        shrinkExtent: shrinkExtent,
        children: children,
      ),
    );
  }
}
