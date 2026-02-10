import 'package:alfie_flutter/data/models/media.dart';

class ProductColor {
  final String id;
  final String name;

  final MediaImage? swatch;
  final List<Media>? media;

  ProductColor({required this.id, required this.name, this.swatch, this.media});
}
