/// Represents pagination information.
///
/// Contains pagination details.
final class Pagination {
  /// The offset of the first item in the current result set.
  final int offset;

  /// The maximum number of items returned per page.
  final int limit;

  /// The total number of items available across all pages.
  final int total;

  /// The total number of pages available, based on offset.
  final int pages;

  /// The current page.
  final int page;

  /// Do we have a next page? (If null, no, else new offset)
  final int? nextPage;

  /// Do we have a previous page? (If null, no, else new offset)
  final int? prevPage;

  /// Creates a new [Pagination] instance.
  Pagination({
    required this.offset,
    required this.limit,
    required this.total,
    required this.pages,
    required this.page,
    this.nextPage,
    this.prevPage,
  });
}
