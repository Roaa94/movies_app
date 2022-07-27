class PaginatedResponse<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  PaginatedResponse({
    this.page = 1,
    this.results = const [],
    this.totalPages = 1,
    this.totalResults = 1,
  });
}
