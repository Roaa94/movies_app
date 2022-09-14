import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';

/// Model for TMDB Images Configs fetched from the /configuration endpoint
///
/// See https://developers.themoviedb.org/3/configuration/get-api-configuration
class TMDBImageConfigs extends Equatable {
  /// Creates new instance of [TMDBImageConfigs]
  const TMDBImageConfigs({
    required this.baseUrl,
    required this.secureBaseUrl,
    this.backdropSizes = const [],
    this.logoSizes = const [],
    this.posterSizes = const [],
    this.profileSizes = const [],
    this.stillSizes = const [],
  });

  /// Creates new instance of [TMDBImageConfigs] from parsed data
  factory TMDBImageConfigs.fromJson(Map<String, dynamic> json) {
    return TMDBImageConfigs(
      baseUrl: json['base_url'] as String,
      secureBaseUrl: json['secure_base_url'] as String,
      backdropSizes: json['backdrop_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['backdrop_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values
                        .firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
      logoSizes: json['logo_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['logo_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values
                        .firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
      posterSizes: json['poster_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['poster_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values
                        .firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
      profileSizes: json['profile_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['profile_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values
                        .firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
      stillSizes: json['still_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['still_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values
                        .firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
    );
  }

  /// The base url of any image path
  ///
  /// i.e. http://image.tmdb.org/t/p/
  final String baseUrl;

  /// The secure base url of any image path
  ///
  /// i.e. https://image.tmdb.org/t/p/
  final String secureBaseUrl;

  /// Available image sizes for a 'backdrop' image
  final List<ImageSize> backdropSizes;

  /// Available image sizes for a 'logo' image
  final List<ImageSize> logoSizes;

  /// Available image sizes for a 'poster' image
  final List<ImageSize> posterSizes;

  /// Available image sizes for a 'profile' image
  final List<ImageSize> profileSizes;

  /// Available image sizes for a 'still' image
  final List<ImageSize> stillSizes;

  /// Builds a valid 'profile' image url given the size and base path
  ///
  /// Example output for [ImageSize.original]
  /// https://image.tmdb.org/t/p/original/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg
  String buildProfileImage(ImageSize size, String path) {
    final imageSize =
        profileSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  /// Builds a valid 'logo' image url given the size and base path
  ///
  /// Example output for [ImageSize.original]
  /// https://image.tmdb.org/t/p/original/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg
  String buildLogoImage(ImageSize size, String path) {
    final imageSize =
        logoSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  /// Builds a valid 'poster' image url given the size and base path
  ///
  /// Example output for [ImageSize.original]
  /// https://image.tmdb.org/t/p/original/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg
  String buildPosterImage(ImageSize size, String path) {
    final imageSize =
        posterSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  /// Builds a valid 'still' image url given the size and base path
  ///
  /// Example output for [ImageSize.original]
  /// https://image.tmdb.org/t/p/original/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg
  String buildStillImage(ImageSize size, String path) {
    final imageSize =
        stillSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  /// Builds a valid 'backdrop' image url given the size and base path
  ///
  /// Example output for [ImageSize.original]
  /// https://image.tmdb.org/t/p/original/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg
  String buildBackdropImage(ImageSize size, String path) {
    final imageSize =
        backdropSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  @override
  List<Object?> get props => [
        baseUrl,
        secureBaseUrl,
        backdropSizes,
        logoSizes,
        posterSizes,
        profileSizes,
        stillSizes,
      ];
}
