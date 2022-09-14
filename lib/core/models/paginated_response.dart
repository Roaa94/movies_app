/// Model representing a paginated TMDB http response
class PaginatedResponse<T> {
  /// Creates new instance of [PaginatedResponse]
  PaginatedResponse({
    this.page = 1,
    this.results = const [],
    this.totalPages = 1,
    this.totalResults = 1,
  });

  /// Creates new instance of [PaginatedResponse] parsed from raw dara
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json, {
    required List<T> results,
  }) {
    return PaginatedResponse<T>(
      page: json['page'] as int,
      results: results,
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }

  /// Page number
  final int page;

  /// List of results of the current page
  final List<T> results;

  /// Total number of pages
  final int totalPages;

  /// Total number of results in all pages
  final int totalResults;
}
