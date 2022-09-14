import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/person_details_provider.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';
import '../../../test-utils/dummy-data/dummy_people.dart';
import '../../../test-utils/mocks.dart';

void main() {
  final PeopleRepository mockPeopleRepository = MockPeopleRepository();

  setUp(() {
    when(
      () => mockPeopleRepository.getPersonDetails(
        DummyPeople.person1.id!,
        forceRefresh: false,
        imageConfigs: DummyConfigs.imageConfigs,
      ),
    ).thenAnswer((_) async => DummyPeople.person1);
  });

  test('fetches person details', () async {
    final personListener = Listener<AsyncValue<Person>>();

    final providerContainer = ProviderContainer(
      overrides: [
        peopleRepositoryProvider.overrideWithValue(mockPeopleRepository),
        tmdbConfigsProvider.overrideWithValue(
          const AsyncValue.data(DummyConfigs.tmdbConfigs),
        ),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen<AsyncValue<Person>>(
      personDetailsProvider(DummyPeople.person1.id!),
      personListener,
      fireImmediately: true,
    );

    // Perform first reading, expects loading state
    final firstReading =
        providerContainer.read(personDetailsProvider(DummyPeople.person1.id!));
    expect(firstReading, const AsyncValue<Person>.loading());

    // Listener was fired from `null` to loading AsyncValue
    verify(
      () => personListener(
        null,
        const AsyncValue<Person>.loading(),
      ),
    ).called(1);

    // Perform second reading, by waiting for the request, expects fetched data
    final secondReading = await providerContainer
        .read(personDetailsProvider(DummyPeople.person1.id!).future);
    expect(secondReading, DummyPeople.person1);

    // Listener was fired from loading to fetched values
    verify(
      () => personListener(
        const AsyncValue<Person>.loading(),
        AsyncValue<Person>.data(DummyPeople.person1),
      ),
    ).called(1);

    // No more further listener events fired
    verifyNoMoreInteractions(personListener);
  });
}
