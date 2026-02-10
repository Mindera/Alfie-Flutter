import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/graphql/extensions/pagination_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/product_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/products.graphql.dart';
import 'package:alfie_flutter/graphql/generated/schema.graphql.dart';

extension ProductListingMapper on Query$ProductListingQuery$productListing {
  ProductListing toDomain() {
    return ProductListing(
      title: title,
      pagination: pagination.toDomain(),
      products: products.map((product) => product.toDomain()).toList(),
    );
  }
}

extension ProductSortMapper on Enum$ProductListingSort {
  ProductListingSort toDomain() {
    switch (this) {
      case Enum$ProductListingSort.LOW_TO_HIGH:
        return ProductListingSort.lowToHigh;
      case Enum$ProductListingSort.HIGH_TO_LOW:
        return ProductListingSort.highToLow;
      case Enum$ProductListingSort.A_Z:
        return ProductListingSort.aToZ;
      case Enum$ProductListingSort.Z_A:
        return ProductListingSort.zToA;
      default:
        return ProductListingSort.relevance;
    }
  }
}

extension ProductListingSortMapper on ProductListingSort {
  Enum$ProductListingSort toGraphQL() {
    switch (this) {
      case ProductListingSort.lowToHigh:
        return Enum$ProductListingSort.LOW_TO_HIGH;
      case ProductListingSort.highToLow:
        return Enum$ProductListingSort.HIGH_TO_LOW;
      case ProductListingSort.aToZ:
        return Enum$ProductListingSort.A_Z;
      case ProductListingSort.zToA:
        return Enum$ProductListingSort.Z_A;
      default:
        return Enum$ProductListingSort.$unknown;
    }
  }
}
