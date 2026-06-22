import 'package:alfie_flutter/ui/product_listing/view/product_listing_view.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_app_bar.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The root component orchestrating the Product Listing Page (PLP) experience.
///
/// Wraps the internal sliver view hierarchy within a [RefreshIndicator] to
/// facilitate manual user-driven data refetching.
class ProductListingScreen extends HookConsumerWidget {
  /// Handles offset delegation for "scroll to top" actions triggered from the nav bar.
  final ScrollController? controller;

  /// The unique query or category identifier defining this listing.
  final ProductListingId id;

  static const pullToRefreshEdgeOffset = 182.0;

  const ProductListingScreen({super.key, required this.id, this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator.adaptive(
      edgeOffset: pullToRefreshEdgeOffset,
      onRefresh: () async {
        ref.read(productListingViewModelProvider(id).notifier).updateCount();
      },
      child: CustomScrollView(
        key: const Key('plp_scroll_view'),
        controller: controller,
        slivers: [
          ProductListingAppBar(id: id),
          ProductListingView(id: id),
        ],
      ),
    );
  }
}
