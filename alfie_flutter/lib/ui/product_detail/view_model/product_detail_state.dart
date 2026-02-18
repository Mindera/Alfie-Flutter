import 'package:alfie_flutter/data/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailState {
  final AsyncValue<Product?> product;

  ProductDetailState({this.product = const AsyncLoading()});

  ProductDetailState copyWith({AsyncValue<Product?>? product}) {
    return ProductDetailState(product: product ?? this.product);
  }
}
