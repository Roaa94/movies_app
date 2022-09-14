// ignore_for_file: avoid_redundant_argument_values
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';

void main() {
  test('returns TMDBConfigs model from valid json', () {
    final rawValidConfigs = <String, dynamic>{
      'base_url': 'http://image.tmdb.org/t/p/',
      'secure_base_url': 'https://image.tmdb.org/t/p/',
      'backdrop_sizes': ['w300', 'w780', 'w1280', 'original'],
      'logo_sizes': ['w45', 'w92', 'w154', 'w185', 'w300', 'w500', 'original'],
      'poster_sizes': [
        'w92',
        'w154',
        'w185',
        'w342',
        'w500',
        'w780',
        'original'
      ],
      'profile_sizes': ['w45', 'w185', 'h632', 'original'],
      'still_sizes': ['w92', 'w185', 'w300', 'original']
    };

    expect(
      TMDBImageConfigs.fromJson(rawValidConfigs),
      equals(DummyConfigs.imageConfigs),
    );
  });

  test(
    'returns TMDBConfigs model with original '
    'image sizes from empty configs image sizes',
    () {
      final rawInvalidConfigs = <String, dynamic>{
        'base_url': 'http://image.tmdb.org/t/p/',
        'secure_base_url': 'https://image.tmdb.org/t/p/',
        'backdrop_sizes': <String>[],
        'logo_sizes': <String>[],
        'poster_sizes': ['invalidValue'],
        'profile_sizes': <String>[],
        'still_sizes': <String>[]
      };

      const validConfigs = TMDBImageConfigs(
        baseUrl: 'http://image.tmdb.org/t/p/',
        secureBaseUrl: 'https://image.tmdb.org/t/p/',
        backdropSizes: <ImageSize>[],
        logoSizes: [],
        posterSizes: [ImageSize.original],
        profileSizes: [],
        stillSizes: [],
      );

      expect(
        TMDBImageConfigs.fromJson(rawInvalidConfigs),
        equals(validConfigs),
      );
    },
  );

  test(
    'returns TMDBConfigs model with empty image '
    'sizes from null configs image sizes',
    () {
      final rawInvalidConfigs = <String, dynamic>{
        'base_url': 'http://image.tmdb.org/t/p/',
        'secure_base_url': 'https://image.tmdb.org/t/p/',
        'backdrop_sizes': null,
        'logo_sizes': null,
        'poster_sizes': null,
        'profile_sizes': null,
        'still_sizes': null
      };

      const validConfigs = TMDBImageConfigs(
        baseUrl: 'http://image.tmdb.org/t/p/',
        secureBaseUrl: 'https://image.tmdb.org/t/p/',
        backdropSizes: [],
        logoSizes: [],
        posterSizes: [],
        profileSizes: [],
        stillSizes: [],
      );

      expect(
        TMDBImageConfigs.fromJson(rawInvalidConfigs),
        equals(validConfigs),
      );
    },
  );

  test('can build profile image Url from size and path', () {
    final generatedImageUrl = DummyConfigs.imageConfigs.buildProfileImage(
      ImageSize.h632,
      '/image-path.png',
    );

    expect(
      generatedImageUrl,
      equals('https://image.tmdb.org/t/p/h632/image-path.png'),
    );
  });

  test('can build backdrop image Url from size and path', () {
    final generatedImageUrl = DummyConfigs.imageConfigs.buildBackdropImage(
      ImageSize.w1280,
      '/image-path.png',
    );

    expect(
      generatedImageUrl,
      equals('https://image.tmdb.org/t/p/w1280/image-path.png'),
    );
  });

  test('can build poster image Url from size and path', () {
    final generatedImageUrl = DummyConfigs.imageConfigs.buildPosterImage(
      ImageSize.w780,
      '/image-path.png',
    );

    expect(
      generatedImageUrl,
      equals('https://image.tmdb.org/t/p/w780/image-path.png'),
    );
  });

  test('can build still image Url from size and path', () {
    final generatedImageUrl = DummyConfigs.imageConfigs.buildStillImage(
      ImageSize.w300,
      '/image-path.png',
    );

    expect(
      generatedImageUrl,
      equals('https://image.tmdb.org/t/p/w300/image-path.png'),
    );
  });

  test('can build logo image Url from size and path', () {
    final generatedImageUrl = DummyConfigs.imageConfigs.buildLogoImage(
      ImageSize.w45,
      '/image-path.png',
    );

    expect(
      generatedImageUrl,
      equals('https://image.tmdb.org/t/p/w45/image-path.png'),
    );

    final generatedImageUrlInvalidSize =
        DummyConfigs.imageConfigs.buildLogoImage(
      ImageSize.h632,
      '/image-path.png',
    );

    expect(
      generatedImageUrlInvalidSize,
      equals('https://image.tmdb.org/t/p/original/image-path.png'),
    );
  });
}
