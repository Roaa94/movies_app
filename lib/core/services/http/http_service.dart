abstract class HttpService {
  String get baseUrl;

  Map<String, String> get headers;

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
  });

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> put();

  Future<dynamic> delete();
}
