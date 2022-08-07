import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/models/person_image.dart';

class PersonImagesGridItem extends StatelessWidget {
  const PersonImagesGridItem(
    this.personImage, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  final PersonImage personImage;
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
