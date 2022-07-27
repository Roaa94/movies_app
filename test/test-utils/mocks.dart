import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';

class MockStorageService extends Mock implements StorageService {}

class MockPeopleRepository extends Mock implements PeopleRepository {}