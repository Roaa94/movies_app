import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/repositories/http_people_repository.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';

void main() {
  test('peopleRepositoryProvider is a HttpPeopleRepository', () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(peopleRepositoryProvider),
      isA<HttpPeopleRepository>(),
    );
  });
}
