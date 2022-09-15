import 'package:movies_app/core/configs/configs.dart';
import 'package:movies_app/core/services/http/http_service.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/repositories/tmdb_configs_repository.dart';

/// Http implementation of [TMDBConfigsRepository]
///
/// See: https://developers.themoviedb.org/3/configuration/get-api-configuration
class HttpTMDBConfigsRepository implements TMDBConfigsRepository {
  /// Creates a new instance of [HttpTMDBConfigsRepository]
  HttpTMDBConfigsRepository(this.httpService);

  /// Http service used to access an Http client and make calls
  final HttpService httpService;

  @override
  String get path => '/configuration';

  @override
  String get apiKey => Configs.tmdbAPIKey;

  @override
  Future<TMDBConfigs> get({bool forceRefresh = false}) async {
    final response = await httpService.get(
      path,
      queryParameters: <String, dynamic>{
        'api_key': apiKey,
      },
      forceRefresh: forceRefresh,
    );

    return TMDBConfigs.fromJson(response);
  }
}
