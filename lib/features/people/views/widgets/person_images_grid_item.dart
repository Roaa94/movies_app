import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/models/person_image.dart';

class PersonImagesGridItem extends StatelessWidget {
  const PersonImagesGridItem(this.personImage, {Key? key}) : super(key: key);
  final PersonImage personImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: personImage.thumbnail == null
          ? Container()
          : AppCachedNetworkImage(
              imageUrl: personImage.thumbnail!,
              fit: BoxFit.cover,
            ),
    );
  }
}
