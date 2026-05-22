/// Defines pagination state and boundaries for a collection of data.
final class Pagination {
  /// The zero-based index of the first item in the current result set.
  final int offset;

  /// The maximum number of items requested per page.
  final int limit;

  /// The total number of items available across all pages.
  final int total;

  /// The total number of pages available, derived from [total] and [limit].
  final int pages;

  /// The current page index.
  final int page;

  /// The offset required to fetch the next page, or `null` if on the last page.
  final int? nextPage;

  /// The offset required to fetch the previous page, or `null` if on the first page.
  final int? prevPage;

  const Pagination({
    required this.offset,
    required this.limit,
    required this.total,
    required this.pages,
    required this.page,
    this.nextPage,
    this.prevPage,
  });
}
