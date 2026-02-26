import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/home/view/carousel_section.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandCarousel extends ConsumerWidget {
  const BrandCarousel({super.key});

  static const double _logoSize = 100;
  static const int _maxLines = 2;
  static const String _title = "Shop by Brand";
  static const String _linkText = "text link";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(homeViewModelProvider).brands;

    return brandsAsync.when(
      loading: () => Center(child: AppIcons.progressIndicator),
      error: (error, _) => Center(child: Text(error.toString())),
      data: (brands) => CarouselSection(
        title: _title,
        linkText: _linkText,
        items: brands,
        contentSize: _logoSize,
        labelMaxLines: _maxLines,
        labelBuilder: (brand) => brand.name,
        itemBuilder: (brand) => Column(
          spacing: Spacing.extraExtraSmall,

          children: [
            Container(
              height: _logoSize,
              color: AppColors.neutral100,
              child: Image.asset('assets/images/alfie.png'),
            ),
          ],
        ),
      ),
    );
  }
}
