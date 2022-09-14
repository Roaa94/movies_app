import 'package:movies_app/core/configs/configs.dart';
import 'package:movies_app/core/services/http/http_service.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/repositories/tmdb_configs_repository.dart';

class HttpTMDBConfigsRepository implements TMDBConfigsRepository {
  final HttpService httpService;

  HttpTMDBConfigsRepository(this.httpService);

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
