import 'dart:async';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';

/// A swipeable gallery that displays a paginated list of widgets.
///
/// It accepts pre-built [children]
/// and handles its own internal presentation state,
/// such as auto-scrolling and pagination indicators.
class Gallery extends HookWidget {
  /// The collection of widgets to display in the gallery.
  final List<Widget> children;

  /// An optional aspect ratio to consistently enforce on each child. If this is null, the gallery will try to have the height of its children.
  final double? aspectRatio;

  /// Whether the gallery should automatically transition between pages.
  final bool autoScroll;

  /// The time interval between automatic page transitions.
  final Duration scrollDuration;

  /// The alignment of the pagination dots.
  final MainAxisAlignment dotsAlignment;

  /// If true, pagination dots are drawn layered over the gallery items.
  /// If false, they are placed directly below the items.
  final bool overlayDots;

  /// If true, uses a darker color palette for the active pagination dot.
  final bool darkDots;

  const Gallery({
    super.key,
    required this.children,
    this.dotsAlignment = MainAxisAlignment.center,
    this.overlayDots = true,
    this.darkDots = false,
    this.aspectRatio,
    this.autoScroll = false,
    this.scrollDuration = const Duration(seconds: 4),
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentPage = useState(0);
    final pageController = usePageController();

    // Tracks user interaction to temporarily pause auto-scrolling.
    final isInteracting = useState(false);

    useEffect(() {
      // Avoid setting up the timer if auto-scroll is disabled,
      // there aren't enough items, or the user is actively touching the gallery.
      if (!autoScroll || children.length <= 1 || isInteracting.value) {
        return null;
      }

      final timer = Timer.periodic(scrollDuration, (_) {
        if (!pageController.hasClients) return;

        final nextPage = (currentPage.value + 1) % children.length;

        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      });

      return timer.cancel;
    }, [autoScroll, children.length, isInteracting.value]);

    final Widget dots = Row(
      mainAxisAlignment: dotsAlignment,
      spacing: Spacing.extraSmall,
      children: List.generate(
        children.length,
        (index) => _DotIndicator(
          isActive: currentPage.value == index,
          darkDots: darkDots,
        ),
      ),
    );

    final Widget pageView = ExpandablePageView.builder(
      controller: pageController,
      itemCount: children.length,
      onPageChanged: (index) => currentPage.value = index,
      itemBuilder: (context, index) {
        final child = aspectRatio == null
            ? children[index]
            : AspectRatio(aspectRatio: aspectRatio!, child: children[index]);

        return Listener(
          onPointerDown: (_) => isInteracting.value = true,
          onPointerUp: (_) => isInteracting.value = false,
          onPointerCancel: (_) => isInteracting.value = false,
          child: child,
        );
      },
    );

    if (children.length <= 1) {
      return pageView;
    }

    if (!overlayDots) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          pageView,
          Padding(
            padding: const EdgeInsets.only(top: Spacing.extraSmall),
            child: dots,
          ),
        ],
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        pageView,
        Padding(padding: const EdgeInsets.all(Spacing.small), child: dots),
      ],
    );
  }
}

/// An animated dot indicator for the gallery pagination.
class _DotIndicator extends StatelessWidget {
  final bool isActive;
  final bool darkDots;

  const _DotIndicator({required this.isActive, required this.darkDots});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 12 : 6,
      decoration: BoxDecoration(
        color: isActive
            ? (darkDots ? AppColors.neutral800 : AppColors.neutral)
            : AppColors.neutral300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
