import 'package:equatable/equatable.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_image_configs.dart';

class TMDBConfigs extends Equatable {
  final TMDBImageConfigs images;

  const TMDBConfigs({
    required this.images,
  });

  factory TMDBConfigs.fromJson(Map<String, dynamic> json) {
    return TMDBConfigs(
      images: TMDBImageConfigs.fromJson(json['images']),
    );
  }

  @override
  List<Object?> get props => [images];
}
