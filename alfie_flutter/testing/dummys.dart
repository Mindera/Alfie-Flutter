import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';

final dummyProducts = [
  Product(
    id: "id1",
    styleNumber: "styleNumber1",
    name: "name1",
    brand: Brand(id: "id", name: "brand"),
    shortDescription: "shortDescription",
    defaultVariant: ProductVariant(
      sku: "sku",
      stock: 1,
      price: Price(
        amount: Money(amount: 2550, currencyCode: 'USD', formatted: r'$25.50'),
      ),
    ),
    variants: [
      ProductVariant(
        sku: "sku",
        stock: 1,
        price: Price(
          amount: Money(
            amount: 2550,
            currencyCode: 'USD',
            formatted: r'$25.50',
          ),
        ),
      ),
    ],
    colours: [
      ProductColor(
        id: "id",
        name: "color",
        media: [
          MediaImage(
                url:
                    'https://images.pexels.com/photos/35255594/pexels-photo-35255594.jpeg',
              )
              as Media,
        ],
      ),
    ],
  ),
  Product(
    id: "id2",
    styleNumber: "styleNumber2",
    name: "name2",
    brand: Brand(id: "id", name: "brand"),
    shortDescription: "shortDescription",
    defaultVariant: ProductVariant(
      sku: "sku",
      stock: 1,
      price: Price(
        amount: Money(amount: 2550, currencyCode: 'USD', formatted: r'$25.50'),
      ),
    ),
    variants: [
      ProductVariant(
        sku: "sku",
        stock: 1,
        price: Price(
          amount: Money(
            amount: 2550,
            currencyCode: 'USD',
            formatted: r'$25.50',
          ),
        ),
      ),
    ],
    colours: [
      ProductColor(
        id: "id",
        name: "color",
        media: [
          MediaImage(
                url:
                    'https://images.pexels.com/photos/35255594/pexels-photo-35255594.jpeg',
              )
              as Media,
        ],
      ),
    ],
  ),
];
