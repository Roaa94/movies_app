import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/services/media/media_service.dart';

void main() {
  test('mediaServiceProvider is a GallerySaverMediaService', () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(mediaServiceProvider),
      isA<GallerySaverMediaService>(),
    );
  });
}
