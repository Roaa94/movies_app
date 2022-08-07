import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/core/widgets/grid_shimmer.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/providers/person_images_provider.dart';
import 'package:movies_app/features/people/views/widgets/person_images_grid.dart';

class PersonImages extends ConsumerWidget {
  const PersonImages(
    this.personId, {
    Key? key,
  }) : super(key: key);

  final int personId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          height: 100,
          left: 0,
          right: 0,
          child: Container(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        Positioned(
          top: 0,
          height: 100,
          left: 0,
          right: 0,
          child: Container(color: AppColors.secondary),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: Container(
            color: AppColors.primary,
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            // width: double.infinity,
            child: ref.watch(personImagesProvider(personId)).when(
              data: (List<PersonImage> images) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 40, end: 17),
                      child: Text(
                        'Images',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    PersonImagesGrid(images),
                  ],
                );
              },
              error: (Object error, StackTrace? stackTrace) {
                log('Error fetching person images');
                log(error.toString());
                return const ErrorView();
              },
              loading: () {
                return Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 40 - 17, end: 17),
                  child: GridShimmer(
                    key: ValueKey('__person_${personId}_images_grid__'),
                    minOpacity: 0.2,
                    maxOpacity: 0.3,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
