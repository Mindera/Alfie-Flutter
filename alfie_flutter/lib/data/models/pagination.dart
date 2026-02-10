class Pagination {
  final int offset;
  final int limit;
  final int total;
  final int pages;
  final int page;
  final int? nextPage;
  final int? prevPage;

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
