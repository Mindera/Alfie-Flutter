import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<ProductColor> createDummyColors({int colorCount = 3}) {
  return List.generate(
    colorCount,
    (index) => ProductColor(
      id: "color-$index",
      name: "Color ${index + 1}",
      media: [
        MediaImage(url: 'https://images.example.com/product-color-$index.jpg')
            as Media,
      ],
    ),
  );
}

/// Creates a dummy product for testing
Product createDummyProduct({
  String id = "test-product-1",
  String name = "Test Product",
  String brandName = "Test Brand",
  String price = r'$99.99',
  bool inStock = true,
  List<ProductColor>? colours,
  String? longDescription,
}) {
  return Product(
    id: id,
    styleNumber: "STYLE-$id",
    name: name,
    brand: Brand(id: "brand-1", name: brandName),
    shortDescription: "Short description for $name",
    longDescription: longDescription,
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
    colours: colours,
  );
}

/// Creates a ProductDetailState with custom parameters
ProductDetailState createDummyProductDetailState({
  required Product? product,
  bool isLoading = false,
  bool hasError = false,
  bool isOnWishlist = false,
  Object? error,
}) {
  late AsyncValue<Product?> productAsync;
  if (isLoading) {
    productAsync = const AsyncLoading();
  } else if (hasError) {
    productAsync = AsyncError(
      error ?? Exception("Test error"),
      StackTrace.current,
    );
  } else {
    productAsync = AsyncData(product);
  }

  return ProductDetailState(product: productAsync, isOnWishlist: isOnWishlist);
}

/// Creates a dummy user for testing
User createDummyUser() {
  return GuestUser(
    id: "test-user-1",
    data: UserData(
      firstName: "Test",
      lastName: "User",
      email: "test@example.com",
      phoneNumber: "+1234567890",
    ),
  );
}
