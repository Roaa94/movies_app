import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/paginated_popular_people_provider.dart';

/// The provider that has the value of the total count of the list items
///
/// The [PaginatedResponse] class contains information about the total number of
/// pages and the total results in all pages along with a list of the
/// provided type
///
/// An example response from the API for any page looks like this:
/// {
///   "page": 1,
///   "results": [], // list of 20 items
///   "total_pages": 500,
///   "total_results": 10000 // Value taken by this provider
/// }
///
/// For infinite scroll tutorial:
/// https://github.com/Roaa94/movies_app/tree/main#infinite-scroll-functionality
final popularPeopleCountProvider = Provider<AsyncValue<int>>((ref) {
  return ref.watch(paginatedPopularPeopleProvider(0)).whenData(
        (PaginatedResponse<Person> pageData) => pageData.totalResults,
      );
});
