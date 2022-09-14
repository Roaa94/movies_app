import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/repositories/tmdb_configs_repository.dart';

/// FutureProvider that fetches TMDB Configurations
/// from the /configurations endpoint
///
/// See: https://developers.themoviedb.org/3/configuration/get-api-configuration
final tmdbConfigsProvider = FutureProvider<TMDBConfigs>((ref) async {
  final tmdbConfigsRepository = ref.watch(tmdbConfigsRepositoryProvider);

  return tmdbConfigsRepository.get();
});
