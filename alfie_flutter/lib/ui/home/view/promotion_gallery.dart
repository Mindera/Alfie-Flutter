import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';

/// A horizontal gallery rendering active marketing promotions.
///
/// Conditionally drops out of the widget tree if [HomeViewModel.promotions] is empty.
class PromotionGallery extends ConsumerWidget {
  const PromotionGallery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promotions = ref.watch(
      homeViewModelProvider.select((viewModel) => viewModel.promotions),
    );

    if (promotions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Gallery(overlayDots: false, darkDots: true, children: promotions);
  }
}
