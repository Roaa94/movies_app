import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_saver/gallery_saver.dart';

/// Provider that maps an [MediaService] interface to implementation
final mediaServiceProvider = Provider<MediaService>(
  (_) => GallerySaverMediaService(),
);

/// Interface for a media service
abstract class MediaService {
  /// Saves a network image to device gallery
  Future<void> saveNetworkImageToGallery(String imageUrl);

  /// Saves a file image to device gallery
  Future<void> saveFileImageToGallery(File file);
}

/// [MediaService] interface implementation using the [GallerySaver] package
///
/// See: https://pub.dev/packages/gallery_saver
class GallerySaverMediaService implements MediaService {
  @override
  // coverage:ignore-start
  Future<void> saveNetworkImageToGallery(String imageUrl) async {
    await GallerySaver.saveImage(imageUrl);
  }

  @override
  Future<void> saveFileImageToGallery(File file) {
    // TODO: implement saveFileImageToGallery
    throw UnimplementedError();
  } // coverage:ignore-end
}
