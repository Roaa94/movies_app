import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';

/// FutureProvider that fetches paginated popular people
///
/// See:
/// https://developers.themoviedb.org/3/people/get-popular-people
/// For infinite scroll tutorial:
/// https://github.com/Roaa94/movies_app/tree/main#infinite-scroll-functionality
final paginatedPopularPeopleProvider =
    FutureProvider.family<PaginatedResponse<Person>, int>(
  (ref, int pageIndex) async {
    final peopleRepository = ref.watch(peopleRepositoryProvider);
    final tmdbConfigs = await ref.watch(tmdbConfigsProvider.future);

    return peopleRepository.getPopularPeople(
      page: pageIndex + 1,
      imageConfigs: tmdbConfigs.images,
    );
  },
);
