import 'package:alfie_flutter/data/models/pagination.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/fragments/pagination_fragment.graphql.dart';

/// Converts a GraphQL Pagination into a domain model.
extension PaginationMapper on Fragment$PaginationFragment {
  /// Converts this pagination fragment to a [Pagination] domain model.
  Pagination toDomain() {
    return Pagination(
      offset: offset,
      limit: limit,
      total: total,
      pages: pages,
      page: page,
      nextPage: nextPage,
      prevPage: previousPage,
    );
  }
}
