import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A swipeable gallery that displays a paginated list of [Media] items.
///
/// Supports both image and video models, displaying the video's first source URL
/// as a thumbnail. Automatically hides pagination indicators if there is only one item.
///
/// TO BE DONE: Video support is not yet implemented
class Gallery extends HookWidget {
  /// The collection of media items to display in the gallery.
  final List<Widget> children;

  final MainAxisAlignment dotsAlignment;

  const Gallery({
    super.key,
    required this.children,
    this.dotsAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentPage = useState(0);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: children.length,
          onPageChanged: (index) => currentPage.value = index,
          itemBuilder: (context, index) {
            return children[index];
          },
        ),

        // Only show pagination dots if there are multiple items to swipe through.
        if (children.length > 1)
          Padding(
            padding: const EdgeInsets.all(Spacing.small),
            child: Row(
              mainAxisAlignment: dotsAlignment,
              spacing: Spacing.extraSmall,
              children: List.generate(
                children.length,
                (index) => _DotIndicator(isActive: currentPage.value == index),
              ),
            ),
          ),
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

  const _DotIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 12 : 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.neutral : AppColors.neutral400,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
