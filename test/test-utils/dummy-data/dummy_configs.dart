import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

class DummyConfigs {
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
}
