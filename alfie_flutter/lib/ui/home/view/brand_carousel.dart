import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/home/view/carousel_section.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';

/// A carousel that displays a list of brands.
///
/// This widget acts as a View in the MVVM pattern, observing [homeViewModelProvider]
/// and mapping brand data to a [CarouselSection].
class BrandCarousel extends ConsumerWidget {
  const BrandCarousel({super.key});

  static const double _logoSize = 100;
  static const int _labelMaxLines = 2;
  static const String _sectionTitle = "Shop by Brand";
  static const String _actionLinkText = "See all";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(
      homeViewModelProvider.select((viewModel) => viewModel.brands),
    );

    return brandsAsync.when(
      loading: () => Center(child: AppIcons.progressIndicator),
      error: (error, _) => Center(child: Text(error.toString())),
      data: (brands) => CarouselSection(
        title: _sectionTitle,
        linkText: _actionLinkText,
        items: brands,
        contentSize: _logoSize,
        labelMaxLines: _labelMaxLines,
        labelBuilder: (brand) => brand.name,
        itemBuilder: (brand) => Container(
          height: _logoSize,
          width: _logoSize,
          decoration: BoxDecoration(
            color: AppColors.neutral100,
            borderRadius: BorderRadius.circular(Spacing.extraSmall),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Spacing.extraSmall),
            // TODO: Replace placeholder with brand.imageUrl once available in the model
            child: Image.asset('assets/images/alfie.png'),
          ),
        ),
      ),
    );
  }
}
