import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/graphql/extensions/pagination_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/product_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/products.graphql.dart';

extension ProductListingMapper on Query$ProductListingQuery$productListing {
  ProductListing toDomain() {
    return ProductListing(
      title: title,
      pagination: pagination.toDomain(),
      products: products.map((product) => product.toDomain()).toList(),
    );
  }
}
