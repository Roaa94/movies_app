import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';
import 'package:movies_app/features/tmdb-configs/repositories/tmdb_configs_repository.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';
import '../../../test-utils/mocks.dart';

void main() {
  final TMDBConfigsRepository mockTMDBConfigsRepository =
      MockTMDBConfigsRepository();

  test('fetches TMDB configs', () async {
    when(() => mockTMDBConfigsRepository.get(forceRefresh: false))
        .thenAnswer((_) async => DummyConfigs.tmdbConfigs);

    final tmdbConfigsListener = Listener<AsyncValue<TMDBConfigs>>();

    final providerContainer = ProviderContainer(
      overrides: [
        // Replace the TMDB Configs repository with the Mock Repository
        tmdbConfigsRepositoryProvider
            .overrideWithValue(mockTMDBConfigsRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen<AsyncValue<TMDBConfigs>>(
      tmdbConfigsProvider,
      tmdbConfigsListener,
      fireImmediately: true,
    );

    // Perform first reading, expects loading state
    final firstReading = providerContainer.read(tmdbConfigsProvider);
    expect(firstReading, const AsyncValue<TMDBConfigs>.loading());

    // Listener was fired from `null` to loading AsyncValue
    verify(() => tmdbConfigsListener(
          null,
          const AsyncValue<TMDBConfigs>.loading(),
        )).called(1);

    // Perform second reading, by waiting for the request, expects fetched data
    final secondReading = await providerContainer.read(tmdbConfigsProvider.future);
    expect(secondReading, DummyConfigs.tmdbConfigs);

    // Listener was fired from loading to fetched values
    verify(() => tmdbConfigsListener(
      const AsyncValue<TMDBConfigs>.loading(),
      const AsyncValue<TMDBConfigs>.data(DummyConfigs.tmdbConfigs),
    )).called(1);

    // No more further listener events fired
    verifyNoMoreInteractions(tmdbConfigsListener);
  });
}
