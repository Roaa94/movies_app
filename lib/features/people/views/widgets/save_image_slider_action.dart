import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';
import 'package:movies_app/core/services/media/media_service.dart';
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
    return SliderAction(
      color: AppColors.secondary,
      icon: const Icon(Icons.download),
      onTap: ref.watch(isLoadingSaveImage)
          ? null
          : () async {
              ref.read(isLoadingSaveImage.notifier).state = true;
              await ref
                  .read(mediaServiceProvider)
                  .saveNetworkImageToGallery(imageUrl);
              ref.read(isLoadingSaveImage.notifier).state = false;
            },
    );
  }
}
