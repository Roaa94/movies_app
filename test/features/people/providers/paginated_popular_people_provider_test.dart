import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/paginated_popular_people_provider.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';
import '../../../test-utils/dummy-data/dummy_people.dart';
import '../../../test-utils/mocks.dart';

void main() {
  final PeopleRepository mockPeopleRepository = MockPeopleRepository();

  setUp(() {
    when(() => mockPeopleRepository.getPopularPeople(
          forceRefresh: false,
          page: 1,
          imageConfigs: DummyConfigs.imageConfigs,
        )).thenAnswer((_) async => DummyPeople.paginatedPopularPeopleResponse);
  });

  test('fetches paginated popular people', () async {
    final popularPeopleListener =
        Listener<AsyncValue<PaginatedResponse<Person>>>();

    final providerContainer = ProviderContainer(
      overrides: [
        peopleRepositoryProvider.overrideWithValue(mockPeopleRepository),
        tmdbConfigsProvider.overrideWithValue(
          const AsyncValue.data(DummyConfigs.tmdbConfigs),
        ),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen<AsyncValue<PaginatedResponse<Person>>>(
      paginatedPopularPeopleProvider(0),
      popularPeopleListener,
      fireImmediately: true,
    );

    // Perform first reading, expects loading state
    final firstReading =
        providerContainer.read(paginatedPopularPeopleProvider(0));
    expect(firstReading, const AsyncValue<PaginatedResponse<Person>>.loading());

    // Listener was fired from `null` to loading AsyncValue
    verify(() => popularPeopleListener(
          null,
          const AsyncValue<PaginatedResponse<Person>>.loading(),
        )).called(1);

    // Perform second reading, by waiting for the request, expects fetched data
    final secondReading =
        await providerContainer.read(paginatedPopularPeopleProvider(0).future);
    expect(secondReading, DummyPeople.paginatedPopularPeopleResponse);

    // Listener was fired from loading to fetched values
    verify(() => popularPeopleListener(
          const AsyncValue<PaginatedResponse<Person>>.loading(),
          AsyncValue<PaginatedResponse<Person>>.data(
              DummyPeople.paginatedPopularPeopleResponse),
        )).called(1);

    // No more further listener events fired
    verifyNoMoreInteractions(popularPeopleListener);
  });
}
