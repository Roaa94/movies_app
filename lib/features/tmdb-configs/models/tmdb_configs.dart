import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

class TMDBConfigs {
  final TMDBImageConfigs images;

  TMDBConfigs({
    required this.images,
  });

  factory TMDBConfigs.fromJson(Map<String, dynamic> json) {
    return TMDBConfigs(
      images: TMDBImageConfigs.fromJson(json['images']),
    );
  }
}
