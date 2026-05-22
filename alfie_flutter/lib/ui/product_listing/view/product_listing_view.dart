import 'package:alfie_flutter/ui/product_listing/view/product_listing_content.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_filter_header.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Organizes the interior body slivers of the Product Listing Page.
///
/// Binds the filter header and core grid content into a unified [SliverMainAxisGroup],
/// delegating layout preferences down from the [productListingViewModelProvider].
class ProductListingView extends ConsumerWidget {
  /// The unique query or category identifier defining this listing.
  final ProductListingId id;

  const ProductListingView({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentColumns = ref.watch(
      productListingViewModelProvider(
        id,
      ).select((state) => state.layoutPreference),
    );

    return SliverMainAxisGroup(
      slivers: [
        ProductListingFilterHeader(
          id: id,
          onColumnsChanged: (newColumns) => ref
              .read(productListingViewModelProvider(id).notifier)
              .updateLayoutPreference(newColumns),
          columns: currentColumns,
        ),
        ProductListingContent(id: id, columns: currentColumns),
      ],
    );
  }
}
