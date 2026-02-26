import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/home/view/carousel_section.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCarousel extends ConsumerWidget {
  const CategoryCarousel({super.key});

  static const double _imageSize = 100;
  static const String _title = "Shop by Brand";
  static const String _linkText = "text link";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModelProvider);

    return CarouselSection(
      title: _title,
      linkText: _linkText,
      items: viewModel.categories,
      contentSize: _imageSize,
      labelBuilder: (category) => category,
      itemBuilder: (category) => Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Spacing.extraExtraSmall,
        children: [
          Container(
            width: _imageSize,
            height: _imageSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.neutral100,
            ),
            child: const Icon(AppIcons.bag),
          ),
        ],
      ),
    );
  }
}
