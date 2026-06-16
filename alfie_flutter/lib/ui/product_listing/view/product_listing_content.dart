import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/vertical_product_card.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Renders the core scrollable grid of products.
///
/// Automatically transitions between asynchronous loading, error, and content
/// states based on the [productListingViewModelProvider] output. Adapts
/// cross-axis count according to the user's [columns] layout preference.
class ProductListingContent extends ConsumerWidget {
  /// The unique query or category identifier defining this listing.
  final ProductListingId id;

  /// The active grid cross-axis layout preference.
  final int columns;

  static const ratios = {1: 0.58, 2: 0.475};

  const ProductListingContent({
    super.key,
    required this.id,
    required this.columns,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelState = ref.watch(
      productListingViewModelProvider(id).select((state) => state.listing),
    );

    return viewModelState.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      loading: () => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: AppIcons.progressIndicator),
      ),
      error: (error, stackTrace) =>
          SliverToBoxAdapter(child: Center(child: Text(error.toString()))),
      data: (productListing) {
        if (productListing == null) {
          return const Center(child: Text("Not Found"));
        }

        return SliverPadding(
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: Spacing.small,
          ),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final product = productListing.products[index];
              final String? label = index == 0 ? "Best Seller" : null;

              return TweenAnimationBuilder<double>(
                key: ValueKey('anim-${product.id}-$columns'),
                duration: const Duration(milliseconds: 300),
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
