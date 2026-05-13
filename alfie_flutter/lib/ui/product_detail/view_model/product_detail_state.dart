import 'package:alfie_flutter/data/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents the presentation state for the Product Detail screen.
///
/// Wraps an [AsyncValue] to natively bridge network loading, error, and data
/// states into the UI, alongside transient interactions like wishlist status.
class ProductDetailState {
  /// The asynchronous network state of the catalog [Product] being viewed.
  final AsyncValue<Product?> product;

  /// Indicates whether this product currently resides in the user's active wishlist.
  final bool isOnWishlist;

  const ProductDetailState({
    this.product = const AsyncLoading(),
    required this.isOnWishlist,
  });

  ProductDetailState copyWith({
    AsyncValue<Product?>? product,
    bool? isOnWishlist,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      isOnWishlist: isOnWishlist ?? this.isOnWishlist,
    );
  }
}
