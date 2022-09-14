// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/services/http/http_service.dart';
import 'package:movies_app/features/people/repositories/http_people_repository.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';
import '../../../test-utils/dummy-data/dummy_people.dart';
import '../../../test-utils/mocks.dart';

void main() {
  final HttpService mockHttpService = MockHttpService();
  final httpPeopleRepository = HttpPeopleRepository(
    mockHttpService,
  );

  test('fetches paginated popular people', () async {
    const page = 1;
    when(
      () => mockHttpService.get(
        '${httpPeopleRepository.path}/popular',
        queryParameters: <String, dynamic>{
          'page': page,
          'api_key': '',
        },
      ),
    ).thenAnswer(
      (_) async => <String, dynamic>{
        'page': page,
        'results': DummyPeople.rawPopularPeople1,
        'total_pages': 1,
        'total_results': 10,
      },
    );

    final paginatedPopularPeople = await httpPeopleRepository.getPopularPeople(
      page: 1,
      imageConfigs: DummyConfigs.imageConfigs,
    );

    expect(
      paginatedPopularPeople.results,
      equals(DummyPeople.popularPeople1),
    );
  });

  test('fetches person details', () async {
    when(
      () => mockHttpService.get(
        '${httpPeopleRepository.path}/${DummyPeople.person1.id}',
        queryParameters: <String, dynamic>{
          'api_key': '',
        },
      ),
    ).thenAnswer(
      (_) async => DummyPeople.rawPerson1,
    );

    final person = await httpPeopleRepository.getPersonDetails(
      DummyPeople.person1.id!,
      imageConfigs: DummyConfigs.imageConfigs,
    );
    expect(person, equals(DummyPeople.person1));
  });

  test('fetches person images', () async {
    when(
      () => mockHttpService.get(
        '${httpPeopleRepository.path}/${DummyPeople.person1.id}/images',
        queryParameters: <String, dynamic>{
          'api_key': '',
        },
      ),
    ).thenAnswer(
      (_) async => <String, dynamic>{
        'profiles': [
          DummyPeople.rawDummyPersonImage1,
          DummyPeople.rawDummyPersonImage2,
        ],
      },
    );

    final personImages = await httpPeopleRepository.getPersonImages(
      DummyPeople.person1.id!,
      imageConfigs: DummyConfigs.imageConfigs,
    );

    expect(
      personImages,
      equals([
        DummyPeople.dummyPersonImage1,
        DummyPeople.dummyPersonImage2,
      ]),
    );
  });
}
