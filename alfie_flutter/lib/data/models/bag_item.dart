import 'package:alfie_flutter/data/models/product.dart';

/// Represents a single line item in the shopping bag, linking a [Product] to its selected [quantity].
class BagItem {
  final Product product;
  final int quantity;

  const BagItem({required this.product, required this.quantity});

  BagItem copyWith({Product? product, int? quantity}) {
    return BagItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
