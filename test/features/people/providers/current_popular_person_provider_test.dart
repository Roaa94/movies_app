import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/providers/current_popular_person_provider.dart';

void main() {
  test('current popular person provider throws UnimplementedError initially',
      () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      () => providerContainer.read(currentPopularPersonProvider),
      throwsA(isA<UnimplementedError>()),
    );
  });
}
