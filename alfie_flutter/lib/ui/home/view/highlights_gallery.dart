import 'package:alfie_flutter/ui/home/view_model/highlight.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/image_utils.dart';

/// A sliver-based gallery that displays featured highlights at the top of the home screen.
///
/// This View observes the [HomeViewModel] and renders a list of high-impact
/// visual cards within a [SliverAppBar].
class HighlightsGallery extends ConsumerWidget {
  /// The fixed aspect ratio for the gallery items.
  static const double galleryAspectRatio = 3 / 4;

  const HighlightsGallery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Selectively watching only the highlights list ensures this gallery
    // doesn't rebuild if other unrelated data in the HomeViewModel changes.
    final highlights = ref.watch(
      homeViewModelProvider.select((viewModel) => viewModel.highlights),
    );

    // Calculate height based on screen width and target aspect ratio to
    // ensure the SliverAppBar occupies the correct vertical space.
    final double expandedHeight =
        context.mediaQuery.size.width / galleryAspectRatio;

    return SliverAppBar(
      primary: false,
      expandedHeight: expandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Gallery(
          aspectRatio: galleryAspectRatio,
          dotsAlignment: MainAxisAlignment.start,
          autoScroll: true,
          children: highlights
              .map((highlight) => _buildHighlightItem(context, highlight))
              .toList(),
        ),
      ),
    );
  }

  /// Constructs an individual image item with gradient and an optional text overlay .
  Widget _buildHighlightItem(BuildContext context, Highlight highlight) {
    return ImageFactory.networkWithGradient(
      highlight.imageUrl,
      foreground: highlight.title != null
          ? Text(
              highlight.title!,
              style: context.textTheme.displayMedium?.copyWith(
                color: AppColors.neutral,
              ),
            )
          : null,
    );
  }
}
