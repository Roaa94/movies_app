import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';

class TMDBImageConfigs extends Equatable {
  final String baseUrl;
  final String secureBaseUrl;
  final List<ImageSize> backdropSizes;
  final List<ImageSize> logoSizes;
  final List<ImageSize> posterSizes;
  final List<ImageSize> profileSizes;
  final List<ImageSize> stillSizes;

  const TMDBImageConfigs({
    required this.baseUrl,
    required this.secureBaseUrl,
    this.backdropSizes = const [],
    this.logoSizes = const [],
    this.posterSizes = const [],
    this.profileSizes = const [],
    this.stillSizes = const [],
  });

  factory TMDBImageConfigs.fromJson(Map<String, dynamic> json) {
    return TMDBImageConfigs(
      baseUrl: json['base_url'],
      secureBaseUrl: json['secure_base_url'],
      backdropSizes: json['backdrop_sizes'] == null
          ? []
          : List<ImageSize>.from(
              json['backdrop_sizes'].map((x) =>
                  ImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  ImageSize.original),
            ),
      logoSizes: json['logo_sizes'] == null
          ? []
          : List<ImageSize>.from(
              json['logo_sizes'].map((x) =>
                  ImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  ImageSize.original),
            ),
      posterSizes: json['poster_sizes'] == null
          ? []
          : List<ImageSize>.from(
              json['poster_sizes'].map((x) =>
                  ImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  ImageSize.original),
            ),
      profileSizes: json['profile_sizes'] == null
          ? []
          : List<ImageSize>.from(
              json['profile_sizes'].map((x) =>
                  ImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  ImageSize.original),
            ),
      stillSizes: json['still_sizes'] == null
          ? []
          : List<ImageSize>.from(
              json['still_sizes'].map((x) =>
                  ImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  ImageSize.original),
            ),
    );
  }

  String buildProfileImage(ImageSize size, String path) {
    String imageSize =
        profileSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  String buildLogoImage(ImageSize size, String path) {
    String imageSize =
        logoSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  String buildPosterImage(ImageSize size, String path) {
    String imageSize =
        posterSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  String buildStillImage(ImageSize size, String path) {
    String imageSize =
        stillSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  String buildBackdropImage(ImageSize size, String path) {
    String imageSize =
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
