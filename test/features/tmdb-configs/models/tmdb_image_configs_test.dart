import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

void main() {
  test('returns TMDBConfigs model from valid json', () {
    Map<String, dynamic> rawValidConfigs = {
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

    const TMDBImageConfigs validConfigs = TMDBImageConfigs(
      baseUrl: 'http://image.tmdb.org/t/p/',
      secureBaseUrl: 'https://image.tmdb.org/t/p/',
      backdropSizes: [
        BackdropImageSize.w300,
        BackdropImageSize.w780,
        BackdropImageSize.w1280,
        BackdropImageSize.original,
      ],
      logoSizes: [
        LogoImageSize.w45,
        LogoImageSize.w92,
        LogoImageSize.w154,
        LogoImageSize.w185,
        LogoImageSize.w300,
        LogoImageSize.w500,
        LogoImageSize.original,
      ],
      posterSizes: [
        PosterImageSize.w92,
        PosterImageSize.w154,
        PosterImageSize.w185,
        PosterImageSize.w342,
        PosterImageSize.w500,
        PosterImageSize.w780,
        PosterImageSize.original,
      ],
      profileSizes: [
        ProfileImageSize.w45,
        ProfileImageSize.w185,
        ProfileImageSize.h632,
        ProfileImageSize.original,
      ],
      stillSizes: [
        StillImageSize.w92,
        StillImageSize.w185,
        StillImageSize.w300,
        StillImageSize.original,
      ],
    );

    expect(
      TMDBImageConfigs.fromJson(rawValidConfigs),
      equals(validConfigs),
    );
  });

  test(
      'returns TMDBConfigs model with original image sizes from empty configs image sizes',
      () {
    Map<String, dynamic> rawInvalidConfigs = {
      'base_url': 'http://image.tmdb.org/t/p/',
      'secure_base_url': 'https://image.tmdb.org/t/p/',
      'backdrop_sizes': [],
      'logo_sizes': [],
      'poster_sizes': ['invalidValue'],
      'profile_sizes': [],
      'still_sizes': []
    };

    const TMDBImageConfigs validConfigs = TMDBImageConfigs(
      baseUrl: 'http://image.tmdb.org/t/p/',
      secureBaseUrl: 'https://image.tmdb.org/t/p/',
      backdropSizes: [],
      logoSizes: [],
      posterSizes: [PosterImageSize.original],
      profileSizes: [],
      stillSizes: [],
    );

    expect(
      TMDBImageConfigs.fromJson(rawInvalidConfigs),
      equals(validConfigs),
    );
  });

  test(
      'returns TMDBConfigs model with empty image sizes from null configs image sizes',
      () {
    Map<String, dynamic> rawInvalidConfigs = {
      'base_url': 'http://image.tmdb.org/t/p/',
      'secure_base_url': 'https://image.tmdb.org/t/p/',
      'backdrop_sizes': null,
      'logo_sizes': null,
      'poster_sizes': null,
      'profile_sizes': null,
      'still_sizes': null
    };

    const TMDBImageConfigs validConfigs = TMDBImageConfigs(
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
  });
}
