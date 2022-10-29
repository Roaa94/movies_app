import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/paginated_popular_people_provider.dart';
import 'package:movies_app/features/people/providers/popular_people_count_provider.dart';

import '../../../test-utils/dummy-data/dummy_people.dart';

void main() {
  test('returns correct results count', () async {
    final providerContainer = ProviderContainer(
      overrides: [
        paginatedPopularPeopleProvider(0).overrideWithProvider(
          FutureProvider<PaginatedResponse<Person>>(
            (ref) async =>
                Future.value(DummyPeople.paginatedPopularPeopleResponse),
          ),
        ),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.read(popularPeopleCountProvider);
    await Future<void>.delayed(Duration.zero);
    final count = providerContainer.read(popularPeopleCountProvider).value;

    expect(
      count,
      equals(DummyPeople.paginatedPopularPeopleResponse.totalResults),
    );
  });
}
