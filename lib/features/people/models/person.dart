import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/features/media/models/media.dart';
import 'package:movies_app/features/people/enums/gender.dart';
import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

/// Model representing a Person object
///
/// See:
/// https://developers.themoviedb.org/3/people/get-popular-people
/// https://developers.themoviedb.org/3/people/get-person-details
class Person extends Equatable {
  /// Creates a new instance of [Person]
  const Person({
    this.adult = false,
    this.gender = Gender.unknown,
    this.id,
    this.knownFor = const [],
    this.knownForDepartment,
    this.name = '',
    this.popularity = 0,
    this.profilePath,
    this.avatar,
    this.cover,
    this.biography,
    this.birthday,
    this.deathDate,
    this.homepage,
    this.imdbId,
    this.placeOfBirth,
  });

  /// Creates a new instance of [Person] from parsed data
  factory Person.fromJson(Map<String, dynamic> json) {
    DateTime? birthday;

    try {
      birthday =
          json['birthday'] == null || (json['birthday'] as String).isEmpty
              ? null
              : DateTime.parse(json['birthday'] as String);
    } catch (e) {
      log('Error parsing birthday date! ${json['birthday']}');
    }
    DateTime? deathDate;

    try {
      deathDate =
          json['deathday'] == null || (json['deathday'] as String).isEmpty
              ? null
              : DateTime.parse(json['deathday'] as String);
    } catch (e) {
      log('Error parsing deathDate date! ${json['deathday']}');
    }
    return Person(
      adult: (json['adult'] as bool?) ?? false,
      gender: json['gender'] == null
          ? Gender.unknown
          : Gender.fromInt(json['gender'] as int),
      id: json['id'] as int?,
      knownFor: json['known_for'] == null
          ? []
          : List<Media>.from(
              (json['known_for'] as List<dynamic>).map<Media>(
                (dynamic x) => Media.fromJson(x as Map<String, dynamic>),
              ),
            ),
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      biography: json['biography'] as String?,
      birthday: birthday,
      deathDate: deathDate,
      homepage: json['homepage'] as String?,
      imdbId: json['imdb_id'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
    );
  }

  /// Indicates if the content of this person is +18
  final bool adult;

  /// Person gender
  final Gender gender;

  /// Person id
  final int? id;

  /// Person media list
  final List<Media> knownFor;

  /// Person departments
  final String? knownForDepartment;

  /// Person name
  final String name;

  /// Person popularity
  final double popularity;

  /// Person profile path
  ///
  /// Used with [TMDBImageConfigs] to generate valid [avatar] & [cover]
  final String? profilePath;

  /// Generated avatar image from [TMDBImageConfigs] & [profilePath]
  final String? avatar;

  /// Generated cover image from [TMDBImageConfigs] & [profilePath]
  final String? cover;

  /// Person biography
  final String? biography;

  /// Person birthday
  final DateTime? birthday;

  /// Person death date if applicable
  final DateTime? deathDate;

  /// Person homepage if applicable
  final String? homepage;

  /// Person IMDB id
  final String? imdbId;

  /// Person place of borth
  final String? placeOfBirth;

  /// Default avatar image size
  static ImageSize avatarSize = ImageSize.h632;

  /// Default avatar cover image size
  static ImageSize coverSize = ImageSize.original;

  /// Converts object to raw data
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'adult': adult,
      'gender': gender.toInt,
      'id': id,
      'known_for': List<dynamic>.from(
        knownFor.map<Map<String, dynamic>>((x) => x.toJson()),
      ),
      'known_for_department': knownForDepartment,
      'name': name,
      'popularity': popularity,
      'profile_path': profilePath,
      'biography': biography,
      'birthday':
          birthday == null ? null : DateFormat('yyyy-MM-dd').format(birthday!),
      'deathday': deathDate == null
          ? null
          : DateFormat('yyyy-MM-dd').format(deathDate!),
      'homepage': homepage,
      'imdb_id': imdbId,
      'place_of_birth': placeOfBirth,
    };
  }

  // Todo: to preserve clean architecture,
  // this should be handled in an entity not the data source model,
  // but it's done this way due to time limitation
  /// Populate the [avatar] and [cover] with generated
  /// valid images from the [TMDBImageConfigs] build image methods
  Person populateImages(TMDBImageConfigs imageConfigs) {
    return Person(
      adult: adult,
      gender: gender,
      id: id,
      knownFor:
          knownFor.map((media) => media.populateImages(imageConfigs)).toList(),
      knownForDepartment: knownForDepartment,
      name: name,
      popularity: popularity,
      profilePath: profilePath,
      avatar: profilePath == null
          ? null
          : imageConfigs.buildProfileImage(avatarSize, profilePath!),
      cover: profilePath == null
          ? null
          : imageConfigs.buildProfileImage(coverSize, profilePath!),
      biography: biography,
      birthday: birthday,
      deathDate: deathDate,
      homepage: homepage,
      imdbId: imdbId,
      placeOfBirth: placeOfBirth,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        gender,
        id,
        knownFor,
        knownForDepartment,
        name,
        popularity,
        profilePath,
        avatar,
        cover,
        biography,
        birthday,
        deathDate,
        homepage,
        imdbId,
        placeOfBirth,
      ];
}
