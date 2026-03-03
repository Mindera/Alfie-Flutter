import 'package:alfie_flutter/ui/product_listing/view/product_listing_content.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_filter_header.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductListingView extends HookWidget {
  const ProductListingView({
    super.key,
    this.initialColumns = 2,
    required this.id,
  });
  final int initialColumns;

  final ProductListingId id;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> columns = useState(initialColumns);
    return SliverMainAxisGroup(
      slivers: [
        ProductListingFilterHeader(
          id: id,
          onColumnsChanged: (newColumns) => columns.value = newColumns,
          columns: columns.value,
        ),
        ProductListingContent(id: id, columns: columns.value),
      ],
    );
  }
}
