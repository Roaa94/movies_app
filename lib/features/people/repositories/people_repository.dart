import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/core/services/http/http_service_provider.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/repositories/http_people_repository.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

/// Provider to map [HttpPeopleRepository] implementation to
/// [PeopleRepository] interface
final peopleRepositoryProvider = Provider<PeopleRepository>(
  (ref) {
    final httpService = ref.watch(httpServiceProvider);

    return HttpPeopleRepository(httpService);
  },
);

/// People repository interface
abstract class PeopleRepository {
  /// TMDB Base endpoint path for people requests
  ///
  /// See: https://developers.themoviedb.org/3/people
  String get path;

  /// API Key used to authenticate TMDB requests
  ///
  /// See: https://developers.themoviedb.org/3/getting-started/introduction
  String get apiKey;

  /// Request to get a person details endpoint
  ///
  /// See: https://developers.themoviedb.org/3/people/get-person-details
  Future<Person> getPersonDetails(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  });

  /// Request to get a list of popular people endpoint
  ///
  /// See: https://developers.themoviedb.org/3/people/get-popular-people
  Future<PaginatedResponse<Person>> getPopularPeople({
    int page = 1,
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  });

  /// Request to get a list of person images endpoint
  ///
  /// See: https://developers.themoviedb.org/3/people/get-person-images
  Future<List<PersonImage>> getPersonImages(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  });
}
