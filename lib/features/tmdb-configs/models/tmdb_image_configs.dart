import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';

class TMDBImageConfigs extends Equatable {
  final String baseUrl;
  final String secureBaseUrl;
  final List<BackdropImageSize> backdropSizes;
  final List<LogoImageSize> logoSizes;
  final List<PosterImageSize> posterSizes;
  final List<ProfileImageSize> profileSizes;
  final List<StillImageSize> stillSizes;

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
          : List<BackdropImageSize>.from(
              json['backdrop_sizes'].map((x) =>
                  BackdropImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  BackdropImageSize.original),
            ),
      logoSizes: json['logo_sizes'] == null
          ? []
          : List<LogoImageSize>.from(
              json['logo_sizes'].map((x) =>
                  LogoImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  LogoImageSize.original),
            ),
      posterSizes: json['poster_sizes'] == null
          ? []
          : List<PosterImageSize>.from(
              json['poster_sizes'].map((x) =>
                  PosterImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  PosterImageSize.original),
            ),
      profileSizes: json['profile_sizes'] == null
          ? []
          : List<ProfileImageSize>.from(
              json['profile_sizes'].map((x) =>
                  ProfileImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  ProfileImageSize.original),
            ),
      stillSizes: json['still_sizes'] == null
          ? []
          : List<StillImageSize>.from(
              json['still_sizes'].map((x) =>
                  StillImageSize.values
                      .firstWhereOrNull((value) => value.name == x) ??
                  StillImageSize.original),
            ),
    );
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
