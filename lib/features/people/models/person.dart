import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/features/media/models/media.dart';
import 'package:movies_app/features/people/enums/gender.dart';

class Person extends Equatable {
  final bool adult;
  final Gender gender;
  final int? id;
  final List<Media> knownFor;
  final String? knownForDepartment;
  final String name;
  final double popularity;
  final String? profilePath;
  final String? biography;
  final DateTime? birthday;
  final DateTime? deathDate;
  final String? homepage;
  final String? imdbId;
  final String? placeOfBirth;

  const Person({
    this.adult = false,
    this.gender = Gender.unknown,
    this.id,
    this.knownFor = const [],
    this.knownForDepartment,
    this.name = '',
    this.popularity = 0,
    this.profilePath,
    this.biography,
    this.birthday,
    this.deathDate,
    this.homepage,
    this.imdbId,
    this.placeOfBirth,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    DateTime? birthday;

    try {
      birthday =
          json['birthday'] == null ? null : DateTime.parse(json['birthday']);
    } catch (e) {
      log('Error parsing birthday date! ${json['birthday']}');
    }
    DateTime? deathDate;

    try {
      deathDate =
          json['deathday'] == null ? null : DateTime.parse(json['deathday']);
    } catch (e) {
      log('Error parsing deathDate date! ${json['deathday']}');
    }
    return Person(
      adult: json['adult'] ?? false,
      gender: json['gender'] == null
          ? Gender.unknown
          : Gender.fromInt(json['gender']),
      id: json['id'],
      knownFor:
          List<Media>.from(json['known_for'].map((x) => Media.fromJson(x))),
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      popularity: json['popularity']?.toDouble() ?? 0.0,
      profilePath: json['profile_path'],
      biography: json['biography'],
      birthday: birthday,
      deathDate: deathDate,
      homepage: json['homepage'],
      imdbId: json['imdb_id'],
      placeOfBirth: json['place_of_birth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'gender': gender.toInt,
      'id': id,
      'known_for': List<dynamic>.from(knownFor.map((x) => x.toJson())),
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
        biography,
        birthday,
        deathDate,
        homepage,
        imdbId,
        placeOfBirth,
      ];
}
