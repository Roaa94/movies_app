import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/repositories/configs_repository.dart';

final tmdbConfigsProvider = FutureProvider<TMDBConfigs>((ref) async {
  final tmdbConfigsRepository = ref.watch(tmdbConfigsRepositoryProvider);

  return await tmdbConfigsRepository.get();
});
