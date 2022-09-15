import 'package:flutter/material.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/views/pages/person_images_slider_page.dart';
import 'package:movies_app/features/people/views/widgets/person_images_grid_item.dart';

/// Widget of the images grid section of the person details
class PersonImagesGrid extends StatelessWidget {
  /// Creates a new instance of [PersonImagesGrid]
  const PersonImagesGrid(
    this.images, {
    Key? key,
  }) : super(key: key);

  /// List of person images to be displayed in the grid
  final List<PersonImage> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (images.length / 3).ceil() *
          ((MediaQuery.of(context).size.width - 10 * 4) / 3),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsetsDirectional.only(start: 40, end: 17),
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: PersonImagesGridItem(
            images[index],
            onTap: () {
              Navigator.of(context).push<PersonImagesSliderPage>(
                MaterialPageRoute<PersonImagesSliderPage>(
                  builder: (context) => PersonImagesSliderPage(
                    images: images,
                    initialImageIndex: index,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
