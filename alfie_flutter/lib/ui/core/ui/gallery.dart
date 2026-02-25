import 'dart:async';

import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:expandable_page_view/expandable_page_view.dart';

/// A swipeable gallery that displays a paginated list of [Media] items.
///
/// Supports both image and video models, displaying the video's first source URL
/// as a thumbnail. Automatically hides pagination indicators if there is only one item.
///
/// TO BE DONE: Video support is not yet implemented
class Gallery extends HookWidget {
  /// The collection of media items to display in the gallery.
  final List<Widget> children;
  final double? aspectRatio;

  final bool autoScroll;
  final Duration scrollDuration;

  final MainAxisAlignment dotsAlignment;
  final bool overlayDots;
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
    final isInteracting = useState(false);

    useEffect(() {
      if (!autoScroll || children.length <= 1) return null;

      Timer? timer;

      void startTimer() {
        timer?.cancel();

        timer = Timer.periodic(scrollDuration, (_) {
          final nextPage = (currentPage.value + 1) % children.length;

          pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );

          currentPage.value = nextPage;
        });
      }

      if (!isInteracting.value) {
        startTimer();
      }

      return () {
        timer?.cancel();
      };
    }, [autoScroll, children.length, isInteracting.value]);

    Widget dots = Row(
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

    Widget pageView = ExpandablePageView.builder(
      controller: pageController,
      itemCount: children.length,
      onPageChanged: (index) => currentPage.value = index,
      itemBuilder: (context, index) {
        return Listener(
          onPointerDown: (_) => isInteracting.value = true,
          onPointerUp: (_) => isInteracting.value = false,
          child: aspectRatio == null
              ? children[index]
              : AspectRatio(aspectRatio: aspectRatio!, child: children[index]),
        );
      },
    );

    if (!overlayDots && children.length > 1) {
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
        if (children.length > 1)
          Padding(padding: const EdgeInsets.all(Spacing.small), child: dots),
      ],
    );
  }
}

/// An animated dot indicator for the gallery pagination.
///
/// Extracted into its own [StatelessWidget] to prevent the entire [Gallery]
/// from rebuilding unnecessarily when a single dot's state changes.
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
