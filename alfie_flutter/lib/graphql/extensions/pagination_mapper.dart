import 'package:alfie_flutter/data/models/pagination.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/fragments/pagination_fragment.graphql.dart';

extension PaginationMapper on Fragment$PaginationFragment {
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
