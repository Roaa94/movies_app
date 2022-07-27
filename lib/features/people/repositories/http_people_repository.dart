import 'package:movies_app/core/configs/configs.dart';
import 'package:movies_app/core/models/paginated_response.dart';
import 'package:movies_app/core/services/http/http_service.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

class HttpPeopleRepository implements PeopleRepository {
  final HttpService httpService;
  final TMDBImageConfigs imageConfigs;

  HttpPeopleRepository(
    this.httpService,
    this.imageConfigs,
  );

  @override
  String get path => '/person';

  @override
  String get apiKey => Configs.tmdbAPIKey;

  @override
  Future<PaginatedResponse<Person>> getPopularPeople({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final responseData = await httpService.get(
      '$path/popular',
      forceRefresh: forceRefresh,
      queryParameters: {
        'page': page,
        'api_key': apiKey,
      },
    );

    return PaginatedResponse.fromJson(
      responseData,
      results: List<Person>.from(
        responseData['results'].map(
          (x) => Person.fromJson(x).populateImages(imageConfigs),
        ),
      ),
    );
  }

  @override
  Future<Person> getPersonDetails(
    int personId, {
    bool forceRefresh = false,
  }) async {
    final responseData = await httpService.get(
      '$path/$personId',
      forceRefresh: forceRefresh,
      queryParameters: {
        'api_key': apiKey,
      },
    );

    return Person.fromJson(responseData).populateImages(imageConfigs);
  }
}
