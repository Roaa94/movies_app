import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/tmdb-configs/repositories/http_tmdb_configs_repository.dart';
import 'package:movies_app/features/tmdb-configs/repositories/tmdb_configs_repository.dart';

void main() {
  test('tmdbConfigsRepositoryProvider is a HttpTMDBConfigsRepository', () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(tmdbConfigsRepositoryProvider),
      isA<HttpTMDBConfigsRepository>(),
    );
  });
}
