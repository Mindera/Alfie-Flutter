import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/home/view/carousel_section.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';

/// A carousel that displays product categories.
///
/// This View component observes the [HomeViewModel] to render a list of
/// categories using a standardized [CarouselSection] layout.
class CategoryCarousel extends ConsumerWidget {
  const CategoryCarousel({super.key});

  static const double _imageSize = 100;
  static const String _sectionTitle = "Shop by Category";
  static const String _actionLinkText = "View all";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(
      homeViewModelProvider.select((viewModel) => viewModel.categories),
    );

    return CarouselSection<String>(
      title: _sectionTitle,
      linkText: _actionLinkText,
      items: categories,
      contentSize: _imageSize,
      labelBuilder: (category) => category,
      itemBuilder: (_) => Container(
        width: _imageSize,
        height: _imageSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.neutral100,
        ),
        // TODO: Replace placeholder icon with category-specific images
        child: const Icon(AppIcons.bag),
      ),
    );
  }
}
