import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/configs/configs.dart';
import 'package:movies_app/core/services/http/http_service.dart';
import 'package:movies_app/core/services/http/http_service_provider.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';

final tmdbConfigsRepositoryProvider = Provider<ConfigsRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);

  return HttpConfigsRepository(httpService);
});

abstract class ConfigsRepository {
  String get path;

  String get apiKey;

  Future<TMDBConfigs> get({bool forceRefresh = false});
}

class HttpConfigsRepository implements ConfigsRepository {
  final HttpService httpService;

  HttpConfigsRepository(this.httpService);

  @override
  String get path => '/configuration';

  @override
  String get apiKey => Configs.tmdbAPIKey;

  @override
  Future<TMDBConfigs> get({bool forceRefresh = false}) async {
    final response = await httpService.get(
      path,
      queryParameters: {
        'api_key': apiKey,
      },
      forceRefresh: forceRefresh,
    );

    return TMDBConfigs.fromJson(response);
  }
}
