import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/media/models/media.dart';
import 'package:movies_app/features/people/enums/gender.dart';
import 'package:movies_app/features/people/models/person.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';

void main() {
  const rawExamplePerson = <String, dynamic>{
    'adult': false,
    'gender': 1,
    'id': 224513,
    'known_for': <String>[],
    'known_for_department': 'Acting',
    'name': 'Ana de Armas',
    'popularity': 493.285,
    'profile_path': '/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg',
    'biography': null,
    'birthday': '1988-04-30',
    'deathday': '2001-04-30',
    'homepage': null,
    'imdb_id': null,
    'place_of_birth': null,
  };

  final examplePerson = Person(
    id: 224513,
    adult: false,
    gender: Gender.female,
    knownFor: const <Media>[],
    knownForDepartment: 'Acting',
    name: 'Ana de Armas',
    popularity: 493.285,
    profilePath: '/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg',
    birthday: DateTime(1988, 4, 30),
    deathDate: DateTime(2001, 4, 30),
    homepage: null,
    imdbId: null,
    placeOfBirth: null,
  );

  test('can parse data fromJson', () {
    expect(Person.fromJson(rawExamplePerson), equals(examplePerson));
  });

  test('can convert data toJson', () {
    expect(examplePerson.toJson(), equals(rawExamplePerson));
  });

  test('returns null dates for invalid formats', () {
    final invalidDateExamplePerson = <String, dynamic>{
      ...rawExamplePerson,
      'deathday': 'invalid!',
      'birthday': 'invalid!',
    };

    expect(Person.fromJson(invalidDateExamplePerson).birthday, isNull);
    expect(Person.fromJson(invalidDateExamplePerson).deathDate, isNull);
  });

  test('can populate avatar and cover from profilePath with correct image urls',
      () {
    final personWithGeneratedImages =
        examplePerson.populateImages(DummyConfigs.imageConfigs);

    final avatarUrl =
        // ignore: lines_longer_than_80_chars
        '${DummyConfigs.imageConfigs.secureBaseUrl}${Person.avatarSize.name}${examplePerson.profilePath}';
    // https://image.tmdb.org/t/p/h632/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg

    expect(
      personWithGeneratedImages.avatar,
      equals(avatarUrl),
    );

    final coverUrl =
        // ignore: lines_longer_than_80_chars
        '${DummyConfigs.imageConfigs.secureBaseUrl}${Person.coverSize.name}${examplePerson.profilePath}';
    // https://image.tmdb.org/t/p/original/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg

    expect(
      personWithGeneratedImages.cover,
      equals(coverUrl),
    );
  });
}
