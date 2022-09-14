// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/media/enums/media_type.dart';
import 'package:movies_app/features/media/models/media.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';

void main() {
  const rawExampleMedia = <String, dynamic>{
    'id': 335984,
    'adult': false,
    'backdrop_path': '/sAtoMqDVhNDQBc3QJL3RF6hlhGq.jpg',
    'genre_ids': [878, 18],
    'media_type': 'movie',
    'original_language': 'en',
    'original_title': 'Blade Runner 2049',
    'overview':
        "Thirty years after the events of the first film, a new blade runner, LAPD Officer K, unearths a long-buried secret that has the potential to plunge what's left of society into chaos. K's discovery leads him on a quest to find Rick Deckard, a former LAPD blade runner who has been missing for 30 years.",
    'poster_path': '/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg',
    'release_date': '2017-10-04',
    'title': 'Blade Runner 2049',
    'video': false,
    'vote_average': 7.5,
    'vote_count': 10892
  };

  final exampleMedia = Media(
    id: 335984,
    adult: false,
    backdropPath: '/sAtoMqDVhNDQBc3QJL3RF6hlhGq.jpg',
    genreIds: const [878, 18],
    mediaType: MediaType.movie,
    originalLanguage: 'en',
    originalTitle: 'Blade Runner 2049',
    overview:
        "Thirty years after the events of the first film, a new blade runner, LAPD Officer K, unearths a long-buried secret that has the potential to plunge what's left of society into chaos. K's discovery leads him on a quest to find Rick Deckard, a former LAPD blade runner who has been missing for 30 years.",
    posterPath: '/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg',
    releaseDate: DateTime(2017, 10, 04),
    title: 'Blade Runner 2049',
    video: false,
    voteAverage: 7.5,
    voteCount: 10892,
  );

  test('can parse data fromJson', () {
    expect(Media.fromJson(rawExampleMedia), equals(exampleMedia));
  });

  test('can convert data toJson', () {
    expect(exampleMedia.toJson(), equals(rawExampleMedia));
  });

  test('has MediaType.unknown for invalid value', () {
    final invalidMediaTypeExampleMedia = <String, dynamic>{
      ...rawExampleMedia,
      'media_type': 'some_invalid_value',
    };

    expect(
      Media.fromJson(invalidMediaTypeExampleMedia).mediaType,
      equals(MediaType.unknown),
    );
  });

  test('returns null release date for invalid format', () {
    final invalidDateExampleMedia = <String, dynamic>{
      ...rawExampleMedia,
      'release_date': 'invalid!',
    };

    expect(Media.fromJson(invalidDateExampleMedia).releaseDate, isNull);
  });

  test(
      'can populate posterThumb and poster from posterPath with correct image urls',
      () {
    final personWithGeneratedImages =
        exampleMedia.populateImages(DummyConfigs.imageConfigs);

    final posterThumb =
        '${DummyConfigs.imageConfigs.secureBaseUrl}${Media.posterThumbSize.name}${exampleMedia.posterPath}';
    // Example: https://image.tmdb.org/t/p/w500/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg

    expect(
      personWithGeneratedImages.posterThumb,
      equals(posterThumb),
    );

    final poster =
        '${DummyConfigs.imageConfigs.secureBaseUrl}${Media.posterSize.name}${exampleMedia.posterPath}';
    // Example: https://image.tmdb.org/t/p/original/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg

    expect(
      personWithGeneratedImages.poster,
      equals(poster),
    );
  });
}
