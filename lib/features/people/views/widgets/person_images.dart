import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/core/widgets/grid_shimmer.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/providers/person_images_provider.dart';

class PersonImages extends ConsumerWidget {
  const PersonImages(
    this.personId, {
    Key? key,
  }) : super(key: key);

  final int personId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
                padding: const EdgeInsetsDirectional.only(start: 40, end: 17),
                child: Text(
                  'Images',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
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
                    child: images[index].thumbnail == null
                        ? Container()
                        : AppCachedNetworkImage(
                            imageUrl: images[index].thumbnail!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching popular people');
          log(error.toString());
          return const Icon(Icons.error);
        },
        loading: () {
          return const Padding(
            padding: EdgeInsetsDirectional.only(start: 40 - 17, end: 17),
            child: GridShimmer(
              minOpacity: 0.2,
              maxOpacity: 0.3,
            ),
          );
        },
      ),
    );
  }
}
