import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/graphql/extensions/product_listing_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/fragments/brand_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/money_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/variant_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/fragments/pagination_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/fragments/product_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/products.graphql.dart';
import 'package:alfie_flutter/graphql/generated/schema.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

// Note: Assuming existence of related fragment mocks or real classes
// for pagination and product mapping tests.

void main() {
  group("Product Listing Mapper Tests -", () {
    test(
      "should map ProductListingQuery response to domain ProductListing model",
      () {
        final mockQueryResponse = Query$ProductListingQuery$productListing(
          title: "Summer Collection",
          pagination: Fragment$PaginationFragment(
            offset: 0,
            limit: 25,
            total: 100,
            pages: 10,
            page: 0,
          ),
          products: <Fragment$ProductFragment>[
            Fragment$ProductFragment(
              id: "0",
              styleNumber: "2123",
              name: "name",
              brand: Fragment$BrandFragment(id: "0", name: "name"),
              shortDescription: "shortDescription",
              slug: "slug",
              defaultVariant: Fragment$VariantFragment(
                sku: '',
                stock: 10,
                price: Fragment$PriceFragment(
                  amount: Fragment$MoneyFragment(
                    currencyCode: "EUR",
                    amount: 1000,
                    amountFormatted: r"$10.00",
                  ),
                ),
              ),
              variants: [],
            ),
          ],
        );

        final result = mockQueryResponse.toDomain();

        expect(result.title, "Summer Collection");
        expect(result.pagination.total, 100);
        expect(result.products, isA<List<Product>>());
      },
    );
  });

  group("Product Sort Mapper Tests (GraphQL to Domain) -", () {
    test("should map LOW_TO_HIGH to lowToHigh", () {
      expect(
        Enum$ProductListingSort.LOW_TO_HIGH.toDomain(),
        ProductListingSort.lowToHigh,
      );
    });

    test("should map HIGH_TO_LOW to highToLow", () {
      expect(
        Enum$ProductListingSort.HIGH_TO_LOW.toDomain(),
        ProductListingSort.highToLow,
      );
    });

    test("should map A_Z to aToZ", () {
      expect(Enum$ProductListingSort.A_Z.toDomain(), ProductListingSort.aToZ);
    });

    test("should map Z_A to zToA", () {
      expect(Enum$ProductListingSort.Z_A.toDomain(), ProductListingSort.zToA);
    });

    test("should default to relevance for unknown or unmapped values", () {
      expect(
        Enum$ProductListingSort.$unknown.toDomain(),
        ProductListingSort.unknown,
      );
    });
  });

  group("Product Sort Mapper Tests (Domain to GraphQL) -", () {
    test("should map lowToHigh to LOW_TO_HIGH", () {
      expect(
        ProductListingSort.lowToHigh.toGraphQL(),
        Enum$ProductListingSort.LOW_TO_HIGH,
      );
    });

    test("should map highToLow to HIGH_TO_LOW", () {
      expect(
        ProductListingSort.highToLow.toGraphQL(),
        Enum$ProductListingSort.HIGH_TO_LOW,
      );
    });

    test("should map aToZ to A_Z", () {
      expect(ProductListingSort.aToZ.toGraphQL(), Enum$ProductListingSort.A_Z);
    });

    test("should map zToA to Z_A", () {
      expect(ProductListingSort.zToA.toGraphQL(), Enum$ProductListingSort.Z_A);
    });

    test("should return \$unknown for relevance or unhandled cases", () {
      expect(
        ProductListingSort.unknown.toGraphQL(),
        Enum$ProductListingSort.$unknown,
      );
    });
  });
}
