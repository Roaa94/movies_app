import 'package:movies_app/core/configs/configs.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/core/services/http/http_service.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

/// Http implementation of the [PeopleRepository]
class HttpPeopleRepository implements PeopleRepository {
  /// Creates a new instance of [HttpPeopleRepository]
  HttpPeopleRepository(this.httpService);

  /// Http service used to access an Http client and make calls
  final HttpService httpService;

  @override
  String get path => '/person';

  @override
  String get apiKey => Configs.tmdbAPIKey;

  @override
  Future<PaginatedResponse<Person>> getPopularPeople({
    int page = 1,
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  }) async {
    final responseData = await httpService.get(
      '$path/popular',
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'page': page,
        'api_key': apiKey,
      },
    );

    return PaginatedResponse.fromJson(
      responseData,
      results: List<Person>.from(
        (responseData['results'] as List<dynamic>).map<Person>(
          (dynamic x) => Person.fromJson(x as Map<String, dynamic>)
              .populateImages(imageConfigs),
        ),
      ),
    );
  }

  @override
  Future<Person> getPersonDetails(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  }) async {
    final responseData = await httpService.get(
      '$path/$personId',
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'api_key': apiKey,
      },
    );

    return Person.fromJson(responseData).populateImages(imageConfigs);
  }

  @override
  Future<List<PersonImage>> getPersonImages(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  }) async {
    final responseData = await httpService.get(
      '$path/$personId/images',
      queryParameters: <String, dynamic>{
        'api_key': apiKey,
      },
    );

    return List<PersonImage>.from(
      (responseData['profiles'] as List<dynamic>).map<PersonImage>(
        (dynamic x) => PersonImage.fromJson(x as Map<String, dynamic>)
            .populateImages(imageConfigs),
      ),
    );
  }
}
