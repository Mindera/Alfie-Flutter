import 'package:alfie_flutter/data/models/product.dart';

/// Represents a single line item in the shopping bag.
class BagItem {
  final Product product;
  final int quantity;

  BagItem({required this.product, required this.quantity});

  BagItem copyWith({Product? product, int? quantity}) {
    return BagItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
