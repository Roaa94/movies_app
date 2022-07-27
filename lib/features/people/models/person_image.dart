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
      aspectRatio: json['aspect_ratio']?.toDouble() ?? 0,
      height: json['height']?.toDouble() ?? 0,
      iso6391: json['iso_639_1'],
      filePath: json['file_path'],
      voteAverage: json['vote_average']?.toDouble() ?? 0,
      voteCount: json['vote_count'] ?? 0,
      width: json['width']?.toDouble() ?? 0,
    );
  }

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
            : imageConfigs.buildProfileImage(ImageSize.original, filePath!),
        thumbnail: filePath == null
            ? null
            : imageConfigs.buildProfileImage(ImageSize.h632, filePath!));
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
