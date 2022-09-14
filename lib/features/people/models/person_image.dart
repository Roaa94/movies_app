import 'package:equatable/equatable.dart';
import 'package:movies_app/features/tmdb-configs/enums/image_size.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

class PersonImage extends Equatable {
  final double aspectRatio;
  final double height;
  final String? iso6391;
  final String? filePath;
  final String? imageUrl;
  final String? thumbnail;
  final double voteAverage;
  final int voteCount;
  final double width;

  const PersonImage({
    this.aspectRatio = 0,
    this.height = 0,
    this.iso6391,
    this.filePath,
    this.voteAverage = 0,
    this.voteCount = 0,
    this.width = 0,
    this.imageUrl,
    this.thumbnail,
  });

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

  static ImageSize imageSize = ImageSize.original;
  static ImageSize thumbnailSize = ImageSize.h632;

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
            : imageConfigs.buildProfileImage(thumbnailSize, filePath!));
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
