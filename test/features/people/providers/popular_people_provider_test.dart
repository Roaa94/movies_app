import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';

import '../../../test-utils/dummy-data/dummy_people.dart';
import '../../../test-utils/mocks.dart';

void main() {
  final PeopleRepository mockPeopleRepository = MockPeopleRepository();

  PaginatedResponse<Person> paginatedPopularPeopleResponse = PaginatedResponse(
    page: 1,
    results: DummyPeople.popularPeople,
    totalPages: 500,
    totalResults: 1000,
  );

  setUp(() {
    when(() =>
            mockPeopleRepository.getPopularPeople(forceRefresh: false, page: 1))
        .thenAnswer((_) async => paginatedPopularPeopleResponse);
  });
}
