import 'package:equatable/equatable.dart';
import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

/// Model for a person's image object
///
/// See: https://developers.themoviedb.org/3/people/get-person-images
class PersonImage extends Equatable {
  /// Creates a new instance of [PersonImage]
  const PersonImage({
    this.aspectRatio = 0,
    this.height = 0,
    this.width = 0,
    this.iso6391,
    this.filePath,
    this.voteAverage = 0,
    this.voteCount = 0,
    this.imageUrl,
    this.thumbnail,
  });

  /// Creates a new instance of [PersonImage] from parsed raw data
  factory PersonImage.fromJson(Map<String, dynamic> json) {
    return PersonImage(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble() ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0,
      iso6391: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      voteCount: (json['vote_count'] as int?) ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0,
    );
  }

  /// Aspect ration of the image
  final double aspectRatio;

  /// Image height
  final double height;

  /// Image width
  final double width;

  /// Image iso6391
  final String? iso6391;

  /// Raw file path of the image
  ///
  /// Used with data from [TMDBImageConfigs] to generate
  /// valid image url
  final String? filePath;

  /// Generated valid image url from [TMDBImageConfigs] and [filePath]
  ///
  /// Example: https://image.tmdb.org/t/p/h632/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg
  final String? imageUrl;

  /// Generated valid image url from [TMDBImageConfigs] and [filePath]
  ///
  /// With [thumbnailSize]
  final String? thumbnail;

  /// Voting average of the image
  final double voteAverage;

  /// Voting count of the image
  final int voteCount;

  /// Default person image size
  static ImageSize imageSize = ImageSize.original;

  /// Default person image thumbnail size
  static ImageSize thumbnailSize = ImageSize.h632;

  /// Populate the [imageUrl] and [thumbnail] with generated
  /// valid images from the [TMDBImageConfigs] build image methods
  PersonImage populateImages(TMDBImageConfigs imageConfigs) {
    return PersonImage(
      aspectRatio: aspectRatio,
      height: height,
      iso6391: iso6391,
      filePath: filePath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      width: width,
      imageUrl: filePath == null
          ? null
          : imageConfigs.buildProfileImage(imageSize, filePath!),
      thumbnail: filePath == null
          ? null
          : imageConfigs.buildProfileImage(thumbnailSize, filePath!),
    );
  }

  @override
  List<Object?> get props => [
        aspectRatio,
        height,
        iso6391,
        filePath,
        voteAverage,
        voteCount,
        width,
        imageUrl,
        thumbnail,
      ];
}
