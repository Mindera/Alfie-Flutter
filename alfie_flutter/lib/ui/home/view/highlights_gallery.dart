import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HighlightsGallery extends ConsumerWidget {
  static const double galleryAspectRatio = 3 / 4;

  const HighlightsGallery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModelProvider);
    return SliverAppBar(
      primary: false,
      expandedHeight: context.mediaQuery.size.width / galleryAspectRatio,
      flexibleSpace: FlexibleSpaceBar(
        background: Gallery(
          aspectRatio: galleryAspectRatio,
          dotsAlignment: MainAxisAlignment.start,
          autoScroll: true,
          children: viewModel.highlights
              .map(
                ((highlight) => ImageFactory.networkWithGradient(
                  highlight.imageUrl,
                  foreground: highlight.title != null
                      ? Text(
                          highlight.title!,
                          style: context.textTheme.displayMedium?.copyWith(
                            color: AppColors.neutral,
                          ),
                        )
                      : null,
                )),
              )
              .toList(),
        ),
      ),
    );
  }
}
