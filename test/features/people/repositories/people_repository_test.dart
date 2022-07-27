import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/repositories/http_people_repository.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_image_configs_provider.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';

void main() {
  test('peopleRepositoryProvider is a HttpPeopleRepository', () {
    final providerContainer = ProviderContainer(overrides: [
      tmdbImageConfigsProvider.overrideWithValue(DummyConfigs.imageConfigs),
    ]);

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(peopleRepositoryProvider),
      isA<HttpPeopleRepository>(),
    );
  });
}
