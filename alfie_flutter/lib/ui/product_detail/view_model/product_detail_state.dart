import 'package:alfie_flutter/data/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents the UI state for the Product Detail screen.
///
/// Wraps an [AsyncValue] to seamlessly handle loading, error, and data states
class ProductDetailState {
  final AsyncValue<Product?> product;
  final bool isOnWishlist;

  const ProductDetailState({this.product = const AsyncLoading(), required this.isOnWishlist});

  ProductDetailState copyWith({AsyncValue<Product?>? product, bool? isOnWishlist}) {
    return ProductDetailState(product: product ?? this.product, isOnWishlist: isOnWishlist ?? this.isOnWishlist);
  }
}
