import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/models/person_image.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';

void main() {
  const rawExamplePersonImage = <String, dynamic>{
    'aspect_ratio': 0.667,
    'height': 900,
    'iso_639_1': null,
    'file_path': '/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg',
    'vote_average': 5.828,
    'vote_count': 113,
    'width': 600,
  };

  const examplePersonImage = PersonImage(
    aspectRatio: 0.667,
    height: 900,
    iso6391: null,
    filePath: '/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg',
    voteAverage: 5.828,
    voteCount: 113,
    width: 600,
  );

  test('can pars data from json', () {
    expect(
      PersonImage.fromJson(rawExamplePersonImage),
      equals(examplePersonImage),
    );
  });

  test('can populate imageUrl & thumbnail with correct image urls', () {
    final examplePersonImageWithImages =
        examplePersonImage.populateImages(DummyConfigs.imageConfigs);

    final imageUrl =
    // ignore: lines_longer_than_80_chars
        '${DummyConfigs.imageConfigs.secureBaseUrl}${PersonImage.imageSize.name}${examplePersonImage.filePath}';
    // https://image.tmdb.org/t/p/original/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg

    expect(examplePersonImageWithImages.imageUrl, equals(imageUrl));

    final thumbnailUrl =
    // ignore: lines_longer_than_80_chars
        '${DummyConfigs.imageConfigs.secureBaseUrl}${PersonImage.thumbnailSize.name}${examplePersonImage.filePath}';
    // https://image.tmdb.org/t/p/h632/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg

    expect(examplePersonImageWithImages.thumbnail, equals(thumbnailUrl));
  });
}
