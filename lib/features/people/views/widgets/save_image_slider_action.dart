import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';
import 'package:movies_app/core/services/media/media_service.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/features/people/views/widgets/slider_action.dart';

/// StateProvider for loading state of image saving action
final isLoadingSaveImage = StateProvider<bool>((_) => false);

/// Slider action widget for saving image to device gallery
class SaveImageSliderAction extends ConsumerWidget {
  /// Creates a new instance of [SaveImageSliderAction]
  const SaveImageSliderAction({
    super.key,
    required this.imageUrl,
  });

  /// Url of the image to be saved
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
