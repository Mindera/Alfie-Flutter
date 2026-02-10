import 'package:alfie_flutter/data/models/pagination.dart';
import 'package:alfie_flutter/data/models/product.dart';

class ProductListing {
  final String title;
  final Pagination pagination;
  final List<Product> products;

  ProductListing({
    required this.title,
    required this.pagination,
    required this.products,
  });
}

enum ProductListingSort { lowToHigh, highToLow, aToZ, zToA, relevance }
