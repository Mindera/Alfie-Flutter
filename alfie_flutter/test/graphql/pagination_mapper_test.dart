import 'package:alfie_flutter/graphql/extensions/pagination_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/fragments/pagination_fragment.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Pagination Mapper Tests -", () {
    test("should map a Pagination Fragment to a domain Pagination model", () {
      final paginationFragment = Fragment$PaginationFragment(
        offset: 20,
        limit: 10,
        total: 100,
        pages: 10,
        page: 3,
        nextPage: 4,
        previousPage: 2,
      );

      final result = paginationFragment.toDomain();

      expect(result.offset, 20);
      expect(result.limit, 10);
      expect(result.total, 100);
      expect(result.pages, 10);
      expect(result.page, 3);
      expect(result.nextPage, 4);
      expect(result.prevPage, 2);
    });

    test("should handle null values for optional page fields", () {
      final paginationFragment = Fragment$PaginationFragment(
        offset: 0,
        limit: 10,
        total: 5,
        pages: 1,
        page: 1,
        nextPage: null,
        previousPage: null,
      );

      final result = paginationFragment.toDomain();

      expect(result.nextPage, isNull);
      expect(result.prevPage, isNull);
    });
  });
}
