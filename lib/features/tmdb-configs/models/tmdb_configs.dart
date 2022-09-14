import 'package:equatable/equatable.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';


/// Model for TMDB Configs fetched from the /configuration endpoint
///
/// See https://developers.themoviedb.org/3/configuration/get-api-configuration
class TMDBConfigs extends Equatable {
  /// Creates new instance of [TMDBConfigs]
  const TMDBConfigs({
    required this.images,
  });

  /// Creates new instance of [TMDBConfigs] from parsed raw data
  factory TMDBConfigs.fromJson(Map<String, dynamic> json) {
    return TMDBConfigs(
      images: TMDBImageConfigs.fromJson(json['images'] as Map<String, dynamic>),
    );
  }

  /// Image configurations information
  final TMDBImageConfigs images;

  @override
  List<Object?> get props => [images];
}
