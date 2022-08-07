import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/services/http/http_service_provider.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/repositories/http_tmdb_configs_repository.dart';

final tmdbConfigsRepositoryProvider = Provider<TMDBConfigsRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);

  return HttpTMDBConfigsRepository(httpService);
});

abstract class TMDBConfigsRepository {
  String get path;

  String get apiKey;

  Future<TMDBConfigs> get({bool forceRefresh = false});
}
