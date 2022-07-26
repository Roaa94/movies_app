class HttpException implements Exception {
  final String? title;
  final String? message;
  final int? statusCode;

  HttpException({
    this.title,
    this.message,
    this.statusCode,
  });
}
