import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/popular_people_provider.dart';

final popularPeopleCountProvider = Provider<AsyncValue<int>>((ref) {
  return ref.watch(paginatedPopularPeopleProvider(0)).whenData(
        (PaginatedResponse<Person> pageData) => pageData.totalResults,
      );
});
