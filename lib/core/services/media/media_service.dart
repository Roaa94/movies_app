import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_saver/gallery_saver.dart';

final mediaServiceProvider = Provider<MediaService>(
  (_) => GallerySaverMediaService(),
);

abstract class MediaService {
  Future<void> saveNetworkImageToGallery(String imageUrl);
}

class GallerySaverMediaService implements MediaService {
  @override
  // coverage:ignore-start
  Future<void> saveNetworkImageToGallery(String imageUrl) async {
    await GallerySaver.saveImage(imageUrl);
  }// coverage:ignore-end
}
