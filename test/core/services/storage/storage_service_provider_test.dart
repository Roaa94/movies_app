import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/services/storage/hive_storage_service.dart';
import 'package:movies_app/core/services/storage/storage_service_provider.dart';

void main() {
  test('serviceProvider returns HiveStorageService', () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(storageServiceProvider),
      isA<HiveStorageService>(),
    );
  });
}
