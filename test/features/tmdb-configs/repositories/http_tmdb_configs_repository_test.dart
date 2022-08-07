import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/services/http/http_service.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/repositories/http_tmdb_configs_repository.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';
import '../../../test-utils/mocks.dart';

void main() {
  final HttpService mockHttpService = MockHttpService();
  final HttpTMDBConfigsRepository httpTMDBConfigsRepository =
      HttpTMDBConfigsRepository(mockHttpService);

  test('fetches TMDB configs', () async {
    when(() => mockHttpService.get(
          httpTMDBConfigsRepository.path,
          queryParameters: {
            'api_key': '',
          },
        )).thenAnswer(
      (_) async => {
        'images': DummyConfigs.rawImageConfigs,
      },
    );

    final TMDBConfigs configs = await httpTMDBConfigsRepository.get();

    expect(
      configs,
      equals(const TMDBConfigs(images: DummyConfigs.imageConfigs)),
    );
  });
}
