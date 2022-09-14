import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';
import 'package:movies_app/core/services/media/media_service.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/features/people/views/widgets/slider_action.dart';

final isLoadingSaveImage = StateProvider<bool>((_) => false);

class SaveImageSliderAction extends ConsumerWidget {
  const SaveImageSliderAction({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isLoadingSaveImage)
        ? const Padding(
            padding: EdgeInsets.all(10),
            child: AppLoader(),
          )
        : SliderAction(
            color: AppColors.secondary,
            icon: const Icon(Icons.download),
            onTap: ref.watch(isLoadingSaveImage)
                ? null
                : () {
                    ref.read(isLoadingSaveImage.notifier).state = true;
                    ref
                        .read(mediaServiceProvider)
                        .saveNetworkImageToGallery(imageUrl)
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Image saved to gallery successfully!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      ref.read(isLoadingSaveImage.notifier).state = false;
                    });
                  },
          );
  }
}
