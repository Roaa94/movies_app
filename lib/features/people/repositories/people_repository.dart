import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/core/services/http/http_service_provider.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/repositories/http_people_repository.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_image_configs_provider.dart';

final peopleRepositoryProvider = Provider<PeopleRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  final imageConfigs = ref.watch(tmdbImageConfigsProvider);

  return HttpPeopleRepository(httpService, imageConfigs);
});

abstract class PeopleRepository {
  String get path;

  String get apiKey;

  Future<Person> getPersonDetails(
    int personId, {
    bool forceRefresh = false,
  });

  Future<PaginatedResponse<Person>> getPopularPeople({
    int page = 1,
    bool forceRefresh = false,
  });
}
