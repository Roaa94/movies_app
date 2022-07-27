import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/core/services/http/http_service.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/repositories/http_people_repository.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';
import '../../../test-utils/dummy-data/dummy_people.dart';
import '../../../test-utils/mocks.dart';

void main() {
  final HttpService mockHttpService = MockHttpService();
  final HttpPeopleRepository httpPeopleRepository = HttpPeopleRepository(
    mockHttpService,
    DummyConfigs.imageConfigs,
  );

  test('fetches paginated popular people', () async {
    int page = 1;
    when(
      () => mockHttpService.get(
        '${httpPeopleRepository.path}/popular',
        queryParameters: {
          'page': page,
          'api_key': '',
        },
      ),
    ).thenAnswer(
      (_) async => {
        'page': page,
        'results': DummyPeople.rawPopularPeople1,
        'total_pages': 1,
        'total_results': 10,
      },
    );

    PaginatedResponse<Person> paginatedPopularPeople =
        await httpPeopleRepository.getPopularPeople(
      page: 1,
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
        queryParameters: {
          'api_key': '',
        },
      ),
    ).thenAnswer(
      (_) async => DummyPeople.rawPerson1,
    );

    final Person person = await httpPeopleRepository.getPersonDetails(
      DummyPeople.person1.id!,
    );
    expect(person, equals(DummyPeople.person1));
  });
}
