import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/product_card.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListingContent extends ConsumerWidget {
  const ProductListingContent({
    super.key,
    required this.categoryId,
    required this.columns,
  });
  final String categoryId;

  final int columns;
  static const ratios = {1: 0.58, 2: 0.48};
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              final product = productListing.products[index];
              String? label = index == 0 ? "Best Seller" : null;

              return TweenAnimationBuilder<double>(
                key: ValueKey('anim-${product.id}-$columns'),

                duration: Duration(milliseconds: 300),

                curve: Curves.easeOut,

                tween: Tween(begin: 0.3, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: VerticalProductCard(product: product, label: label),
              );
            }, childCount: productListing.products.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: Spacing.extraSmall,
              mainAxisSpacing: Spacing.small,
              childAspectRatio: ratios[columns]!,
            ),
          ),
        );
      },
    );
  }
}
