class ProductSize {
  final String id;
  final String value;
  final String? scale;
  final String? description;
  final SizeGuide? sizeGuide;

  ProductSize({
    required this.id,
    required this.value,
    this.scale,
    this.description,
    this.sizeGuide,
  });
}

class SizeGuide {
  final String id;
  final String name;
  final String? description;
  final List<ProductSize> sizes;

  SizeGuide({
    required this.id,
    required this.name,
    this.description,
    required this.sizes,
  });
}
