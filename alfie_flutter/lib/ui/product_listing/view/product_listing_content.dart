import 'dart:developer';

import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/product_card.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListingContent extends ConsumerWidget {
  const ProductListingContent({super.key, required this.categoryId});
  final String categoryId;

  final int columns = 2;
  static const ratios = {2: 0.49};
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("rebuilt content");
    final viewModelState = ref.watch(
      productListingViewModelProvider(categoryId),
    );
    return viewModelState.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,

      loading: () => SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: AppIcons.progressIndicator),
      ),
      error: (error, stackTrace) =>
          SliverToBoxAdapter(child: Center(child: Text(error.toString()))),
      data: (state) {
        final productListing = state.listing;
        if (productListing == null) {
          return Center(child: Text("Not Foumd"));
        }

        return SliverPadding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: Spacing.small),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              String? label = index == 0 ? "Best Seller" : null;
              return VerticalProductCard(
                product: productListing.products[index],
                label: label,
              );
            }, childCount: productListing.products.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: Spacing.extraSmall,
              mainAxisSpacing: Spacing.small,
              childAspectRatio: 0.49,
            ),
          ),
        );
      },
    );
  }
}
