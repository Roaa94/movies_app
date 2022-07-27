import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';

final paginatedPopularPeopleProvider =
    FutureProvider.family<PaginatedResponse<Person>, int>(
  (ref, int pageIndex) async {
    final peopleRepository = ref.watch(peopleRepositoryProvider);

    return await peopleRepository.getPopularPeople(
      page: pageIndex + 1,
    );
  },
);
