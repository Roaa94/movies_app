import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/providers/paginated_popular_people_provider.dart';
import 'package:movies_app/features/people/providers/popular_people_count_provider.dart';

import '../../../test-utils/dummy-data/dummy_people.dart';

void main() {
  test('returns correct results count', () async {
    final providerContainer = ProviderContainer(
      overrides: [
        paginatedPopularPeopleProvider(0).overrideWithValue(
          AsyncValue.data(DummyPeople.paginatedPopularPeopleResponse),
        ),
      ],
    );

    addTearDown(providerContainer.dispose);

    final count =
        await providerContainer.read(popularPeopleCountProvider.future);

    expect(
      count,
      equals(DummyPeople.paginatedPopularPeopleResponse.totalResults),
    );
  });
}
