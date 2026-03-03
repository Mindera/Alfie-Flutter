import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';

/// A Riverpod-powered gallery used to display promotional banners.
///
/// This View component observes the [homeViewModelProvider] to render
/// a list of promotion widgets.
class PromotionGallery extends ConsumerWidget {
  const PromotionGallery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Selectively watching only the promotions list ensures this gallery
    // doesn't rebuild if other unrelated data in the HomeViewModel changes.
    final promotions = ref.watch(
      homeViewModelProvider.select((viewModel) => viewModel.promotions),
    );

    if (promotions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Gallery(overlayDots: false, darkDots: true, children: promotions);
  }
}
