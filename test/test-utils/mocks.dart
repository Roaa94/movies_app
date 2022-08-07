import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/services/http/http_service.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/repositories/tmdb_configs_repository.dart';

class MockStorageService extends Mock implements StorageService {}

class MockPeopleRepository extends Mock implements PeopleRepository {}

class MockHttpService extends Mock implements HttpService {}

class MockTMDBConfigsRepository extends Mock implements TMDBConfigsRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T value);
}