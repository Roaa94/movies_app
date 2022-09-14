/// Custom exception used with Http requests
class HttpException implements Exception {
  /// Creates a new instance of [HttpException]
  HttpException({
    this.title,
    this.message,
    this.statusCode,
  });

  /// Exception title
  final String? title;

  /// Exception message
  final String? message;

  /// Exception http response code
  final int? statusCode;
}
