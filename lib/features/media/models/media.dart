import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/features/media/enums/media_type.dart';

class Media extends Equatable {
  final int id;
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final MediaType mediaType;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool video;
  final double voteAverage;
  final int voteCount;

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
    this.releaseDate,
    this.title,
    this.video = false,
    this.voteAverage = 0,
    this.voteCount = 0,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    MediaType mediaType = MediaType.unknown;
    try {
      mediaType = MediaType.values.byName(json['media_type']);
    } catch (_) {
      log('Unknown media type!');
    }

    return Media(
      id: json['id'],
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'],
      mediaType: mediaType,
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date']),
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': List<int>.from(genreIds.map((x) => x)),
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
