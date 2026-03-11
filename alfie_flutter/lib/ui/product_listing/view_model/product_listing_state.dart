import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListingState {
  final ProductListingParams params;
  final AsyncValue<ProductListing?> listing;
  final int layoutPreference;

  static const _defaultLayoutPreference = 2;

  const ProductListingState({
    required this.params,
    required this.listing,
    int? layoutPreference,
  }) : layoutPreference = layoutPreference ?? _defaultLayoutPreference;

  ProductListingState copyWith({
    ProductListingParams? params,
    AsyncValue<ProductListing?>? listing,
    int? layoutPreference,
  }) {
    return ProductListingState(
      params: params ?? this.params,
      listing: listing ?? this.listing,
      layoutPreference: layoutPreference ?? this.layoutPreference,
    );
  }
}
