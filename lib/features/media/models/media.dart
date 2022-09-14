import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/features/media/enums/media_type.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

/// Model representing a media object
/// which holds information about a [MediaType.tv] or [MediaType.movie]
///
/// Generally used in a [Person] model for the 'knownFor' field
/// See: https://developers.themoviedb.org/3/people/get-popular-people
class Media extends Equatable {
  /// Creates a new instance of [Media]
  const Media({
    required this.id,
    this.adult = false,
    this.backdropPath,
    this.genreIds = const [],
    this.mediaType = MediaType.unknown,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.posterThumb,
    this.poster,
    this.releaseDate,
    this.title,
    this.video = false,
    this.voteAverage = 0,
    this.voteCount = 0,
  });

  /// Creates a new instance of [Media] from parsed raw data
  factory Media.fromJson(Map<String, dynamic> json) {
    var mediaType = MediaType.unknown;
    try {
      mediaType = MediaType.values.byName(json['media_type'] as String);
    } catch (_) {
      log('Unknown media type!');
    }

    DateTime? releaseDate;
    try {
      releaseDate = json['release_date'] == null ||
              (json['release_date'] as String).isEmpty
          ? null
          : DateTime.parse(json['release_date'] as String);
    } catch (e) {
      log('Error parsing releaseDate date! ${json['release_date']}');
    }

    return Media(
      id: json['id'] as int,
      adult: (json['adult'] as bool?) ?? false,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: List<int>.from(
        (json['genre_ids'] as List<dynamic>).map<int>((dynamic x) => x as int),
      ),
      mediaType: mediaType,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: releaseDate,
      title: json['title'] as String?,
      video: (json['video'] as bool?) ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as int?) ?? 0,
    );
  }

  /// Object id
  final int id;

  /// Indicates if the media is +18
  final bool adult;

  /// 'backdrop' image path
  final String? backdropPath;

  /// list of genre ids
  final List<int> genreIds;
  final MediaType mediaType;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? posterThumb;
  final String? poster;
  final DateTime? releaseDate;
  final String? title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  /// Converts object to raw data
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'media_type': mediaType.name,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate == null
          ? null
          : DateFormat('yyyy-MM-dd').format(releaseDate!),
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  /// Default 'poster' thumbnail size
  static ImageSize posterThumbSize = ImageSize.w500;

  /// Default 'poster' size
  static ImageSize posterSize = ImageSize.original;

  // Todo: to preserve clean architecture,
  // this should be handled in an entity not the data source model,
  // but it's done this way due to time limitation
  /// Populate the [poster] and [posterThumb] with generated
  /// valid images from the [TMDBImageConfigs] build image methods
  Media populateImages(TMDBImageConfigs imageConfigs) {
    return Media(
      id: id,
      adult: adult,
      backdropPath: backdropPath,
      genreIds: genreIds,
      mediaType: mediaType,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      posterThumb: posterPath == null
          ? null
          : imageConfigs.buildPosterImage(posterThumbSize, posterPath!),
      poster: posterPath == null
          ? null
          : imageConfigs.buildPosterImage(posterSize, posterPath!),
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        adult,
        backdropPath,
        genreIds,
        mediaType,
        originalLanguage,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
