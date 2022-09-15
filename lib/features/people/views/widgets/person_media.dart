import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/media/models/media.dart';

/// List widget of a Person's 'knownFor' Media (movies & tv shows)
class PersonMedia extends StatelessWidget {
  /// Creates a new instance of [PersonMedia]
  const PersonMedia(
    this.media, {
    Key? key,
  }) : super(key: key);

  /// Media list
  final List<Media> media;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: 100,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(color: AppColors.primary),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: Container(
            color: AppColors.secondary,
            padding: const EdgeInsetsDirectional.only(top: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 40, end: 17),
                  child: Text(
                    'Movies & TV Shows',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    padding:
                        const EdgeInsetsDirectional.only(start: 40, end: 17),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: media.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(end: 15),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: media[index].posterThumb == null
                                ? Container()
                                : AppCachedNetworkImage(
                                    imageUrl: media[index].posterThumb!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
