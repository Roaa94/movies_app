import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/services/http/http_service_provider.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/repositories/http_tmdb_configs_repository.dart';

/// Provider to map [HttpTMDBConfigsRepository] implementation to
/// [TMDBConfigsRepository] interface
final tmdbConfigsRepositoryProvider = Provider<TMDBConfigsRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);

  return HttpTMDBConfigsRepository(httpService);
});

/// TMDB Configurations repository interface
abstract class TMDBConfigsRepository {
  /// TMDB Base endpoint path for configurations endpoint
  ///
  /// See: https://developers.themoviedb.org/3/configuration/get-api-configuration
  String get path;

  /// API Key used to authenticate TMDB requests
  ///
  /// See: https://developers.themoviedb.org/3/getting-started/introduction
  String get apiKey;

  /// Request to get TMDB configurations endpoint
  ///
  /// See: https://developers.themoviedb.org/3/configuration/get-api-configuration
  Future<TMDBConfigs> get({bool forceRefresh = false});
}
