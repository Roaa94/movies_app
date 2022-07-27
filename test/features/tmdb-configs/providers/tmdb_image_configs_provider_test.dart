import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_image_configs_provider.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';

void main() {
  test('throws UnimplementedError when accessed without being overriden', () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      () => providerContainer.read(tmdbImageConfigsProvider),
      throwsA(isA<ProviderException>()),
    );
    try {
      providerContainer.read(tmdbImageConfigsProvider);
    } catch (e) {
      expect(e, isA<ProviderException>());
      expect((e as ProviderException).exception, isA<UnimplementedError>());
    }
  });

  test('throws UnimplementedError when accessed without being overridden', () {
    final providerContainer = ProviderContainer(overrides: [
      tmdbImageConfigsProvider.overrideWithValue(DummyConfigs.imageConfigs),
    ]);

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(tmdbImageConfigsProvider),
      equals(DummyConfigs.imageConfigs),
    );
  });
}
