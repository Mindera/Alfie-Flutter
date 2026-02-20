import 'dart:developer';

import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListingFilterHeader extends ConsumerWidget {
  const ProductListingFilterHeader({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("built header");
    final productCount = ref.watch(
      productListingViewModelProvider(
        categoryId,
      ).select((s) => s.value?.listing?.products.length),
    );
    return SliverAppBar(
      pinned: true,
      primary: false,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.neutral,
      surfaceTintColor: Colors.transparent,
      elevation: 0,

      toolbarHeight: _ProductListingFilterHeader.headerHeight,

      flexibleSpace: _ProductListingFilterHeader(totalItems: productCount),
    );
  }
}

class _ProductListingFilterHeader extends StatelessWidget {
  const _ProductListingFilterHeader({required this.totalItems});

  static const labels = ["Slim Fit", "Linen", "Cotton", "Straight Fit"];
  final int? totalItems;
  static const double headerHeight = 82.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Spacing.small,
        right: Spacing.small,
        bottom: Spacing.extraSmall,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton.tertiary(
                    leading: AppIcons.grid2,
                    size: ButtonSize.small,
                    onPressed: () {},
                  ),
                  AppButton.tertiary(
                    leading: AppIcons.grid3,
                    size: ButtonSize.small,
                    onPressed: () {},
                  ),
                ],
              ),
              if (totalItems != null) Text("$totalItems items"),
              Text("Refine", style: context.textTheme.linkMedium),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Spacing.extraExtraSmall),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                spacing: Spacing.extraSmall,
                children: labels
                    .map(
                      (label) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.small,
                          vertical: Spacing.extraExtraSmall,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.neutral800),
                          borderRadius: BorderRadius.circular(Spacing.medium),
                        ),

                        child: Center(child: Text(label)),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
