import 'package:alfie_flutter/ui/product_listing/view/product_listing_app_bar.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_filter_header.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_content.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListingScreen extends ConsumerWidget {
  final ScrollController? controller;
  final String categoryId;
  static const pullToRefreshEdgeOffset = 182.0;

  const ProductListingScreen({
    super.key,
    required this.categoryId,
    this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator.adaptive(
      edgeOffset: pullToRefreshEdgeOffset,
      onRefresh: () async {
        ref
            .read(productListingViewModelProvider(categoryId).notifier)
            .updateCount();
      },
      child: CustomScrollView(
        controller: controller,
        slivers: [
          ProductListingAppBar(categoryId: categoryId),
          ProductListingFilterHeader(categoryId: categoryId),
          ProductListingContent(categoryId: categoryId),
        ],
      ),
    );
  }
}
