import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

class DummyConfigs {
  static const Map<String, dynamic> rawImageConfigs = {
    'base_url': 'http://image.tmdb.org/t/p/',
    'secure_base_url': 'https://image.tmdb.org/t/p/',
    'backdrop_sizes': ['w300', 'w780', 'w1280', 'original'],
    'logo_sizes': ['w45', 'w92', 'w154', 'w185', 'w300', 'w500', 'original'],
    'poster_sizes': ['w92', 'w154', 'w185', 'w342', 'w500', 'w780', 'original'],
    'profile_sizes': ['w45', 'w185', 'h632', 'original'],
    'still_sizes': ['w92', 'w185', 'w300', 'original']
  };

  static const TMDBConfigs tmdbConfigs = TMDBConfigs(
    images: imageConfigs,
  );

  static const TMDBImageConfigs imageConfigs = TMDBImageConfigs(
    baseUrl: 'http://image.tmdb.org/t/p/',
    secureBaseUrl: 'https://image.tmdb.org/t/p/',
    backdropSizes: [
      ImageSize.w300,
      ImageSize.w780,
      ImageSize.w1280,
      ImageSize.original,
    ],
    logoSizes: [
      ImageSize.w45,
      ImageSize.w92,
      ImageSize.w154,
      ImageSize.w185,
      ImageSize.w300,
      ImageSize.w500,
      ImageSize.original,
    ],
    posterSizes: [
      ImageSize.w92,
      ImageSize.w154,
      ImageSize.w185,
      ImageSize.w342,
      ImageSize.w500,
      ImageSize.w780,
      ImageSize.original,
    ],
    profileSizes: [
      ImageSize.w45,
      ImageSize.w185,
      ImageSize.h632,
      ImageSize.original,
    ],
    stillSizes: [
      ImageSize.w92,
      ImageSize.w185,
      ImageSize.w300,
      ImageSize.original,
    ],
  );

  static const TMDBImageConfigs imageConfigsDummyUrl = TMDBImageConfigs(
    baseUrl: 'image.tmdb.org/t/p/',
    secureBaseUrl: 'image.tmdb.org/t/p/',
    backdropSizes: [
      ImageSize.w300,
      ImageSize.w780,
      ImageSize.w1280,
      ImageSize.original,
    ],
    logoSizes: [
      ImageSize.w45,
      ImageSize.w92,
      ImageSize.w154,
      ImageSize.w185,
      ImageSize.w300,
      ImageSize.w500,
      ImageSize.original,
    ],
    posterSizes: [
      ImageSize.w92,
      ImageSize.w154,
      ImageSize.w185,
      ImageSize.w342,
      ImageSize.w500,
      ImageSize.w780,
      ImageSize.original,
    ],
    profileSizes: [
      ImageSize.w45,
      ImageSize.w185,
      ImageSize.h632,
      ImageSize.original,
    ],
    stillSizes: [
      ImageSize.w92,
      ImageSize.w185,
      ImageSize.w300,
      ImageSize.original,
    ],
  );
}
