import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Creates a dummy product for testing
Product createDummyProduct({
  String id = "test-product-1",
  String name = "Test Product",
  String brandName = "Test Brand",
  String price = r'$99.99',
  int colorCount = 1,
  bool inStock = true,
}) {
  return Product(
    id: id,
    styleNumber: "STYLE-$id",
    name: name,
    brand: Brand(id: "brand-1", name: brandName),
    shortDescription: "Short description for $name",
    longDescription:
        "This is a detailed description for $name. It contains comprehensive product information.",
    defaultVariant: ProductVariant(
      sku: "SKU-$id",
      stock: inStock ? 5 : 0,
      price: Price(
        amount: Money(amount: 9999, currencyCode: 'USD', formatted: price),
      ),
    ),
    variants: [
      ProductVariant(
        sku: "SKU-$id-V1",
        stock: inStock ? 5 : 0,
        price: Price(
          amount: Money(amount: 9999, currencyCode: 'USD', formatted: price),
        ),
      ),
    ],
    colours: List.generate(
      colorCount,
      (index) => ProductColor(
        id: "color-$index",
        name: "Color ${index + 1}",
        media: [
          MediaImage(
                url: 'https://images.example.com/product-$id-color-$index.jpg',
              )
              as Media,
        ],
      ),
    ),
  );
}

/// Creates a ProductDetailState with custom parameters
ProductDetailState createDummyProductDetailState({
  Product? product,
  bool isLoading = false,
  bool hasError = false,
  bool isOnWishlist = false,
  Object? error,
}) {
  final prod = product ?? createDummyProduct();

  late AsyncValue<Product?> productAsync;
  if (isLoading) {
    productAsync = const AsyncLoading();
  } else if (hasError) {
    productAsync = AsyncError(
      error ?? Exception("Test error"),
      StackTrace.current,
    );
  } else {
    productAsync = AsyncData(prod);
  }

  return ProductDetailState(product: productAsync, isOnWishlist: isOnWishlist);
}
