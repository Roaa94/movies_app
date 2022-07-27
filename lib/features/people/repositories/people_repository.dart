import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/core/services/http/http_service_provider.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/repositories/http_people_repository.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

final peopleRepositoryProvider = Provider<PeopleRepository>(
  (ref) {
    final httpService = ref.watch(httpServiceProvider);

    return HttpPeopleRepository(httpService);
  },
);

abstract class PeopleRepository {
  String get path;

  String get apiKey;

  Future<Person> getPersonDetails(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  });

  Future<PaginatedResponse<Person>> getPopularPeople({
    int page = 1,
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  });

  Future<List<PersonImage>> getPersonImages(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  });
}
