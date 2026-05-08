import 'package:alfie_flutter/ui/home/view_model/highlight.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/image_utils.dart';

/// A dynamic sliver gallery displaying high-impact feature content.
///
/// Embedded natively within a [SliverAppBar] flexible space, allowing it to
/// collapse or expand synchronously with the root viewport scroll position.
class HighlightsGallery extends ConsumerWidget {
  /// Enforces a strict 3:4 aspect ratio for all featured imagery.
  static const double galleryAspectRatio = 3 / 4;

  const HighlightsGallery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
