import 'package:alfie_flutter/ui/product_listing/view/product_listing_app_bar.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_filter_header.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_content.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListingScreen extends HookConsumerWidget {
  final ScrollController? controller;
  final String categoryId;
  static const pullToRefreshEdgeOffset = 182.0;
  final int initialColumns;

  const ProductListingScreen({
    super.key,
    required this.categoryId,
    this.controller,
    this.initialColumns = 2,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<int> columns = useState(initialColumns);

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
          ProductListingFilterHeader(
            columns: columns.value,
            categoryId: categoryId,
            onColumnsChanged: (c) => columns.value = c,
          ),
          ProductListingContent(categoryId: categoryId, columns: columns.value),
        ],
      ),
    );
  }
}
