import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/models/person_image.dart';

/// Widget of a person images section grid item
class PersonImagesGridItem extends StatelessWidget {
  /// Creates a new instance of [PersonImagesGridItem]
  const PersonImagesGridItem(
    this.personImage, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  /// Image item of the person images grid
  final PersonImage personImage;

  /// Callback for tap event on image item
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: personImage.thumbnail == null
          ? Container(color: Colors.white)
          : AppCachedNetworkImage(
              imageUrl: personImage.thumbnail!,
              fit: BoxFit.cover,
            ),
    );
  }
}
