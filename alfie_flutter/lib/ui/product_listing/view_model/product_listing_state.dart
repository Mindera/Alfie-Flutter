import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';

class ProductListingState {
  final ProductListingParams params;
  final ProductListing? listing;

  const ProductListingState({required this.params, required this.listing});

  ProductListingState copyWith({
    ProductListingParams? params,
    ProductListing? listing,
  }) {
    return ProductListingState(
      params: params ?? this.params,
      listing: listing ?? this.listing,
    );
  }
}
