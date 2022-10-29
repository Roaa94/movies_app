import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/views/widgets/save_image_slider_action.dart';
import 'package:movies_app/features/people/views/widgets/slider_action.dart';

/// Slider widget for person images
class PersonImagesSliderPage extends StatefulWidget {
  /// Creates a new instance of [PersonImagesSliderPage]
  const PersonImagesSliderPage({
    super.key,
    this.initialImageIndex = 0,
    required this.images,
  });

  /// The initial image index to the slider should first open to
  final int initialImageIndex;

  /// The list of person images displayed in the slider
  final List<PersonImage> images;

  @override
  State<PersonImagesSliderPage> createState() => PersonImagesSliderPageState();
}

/// Person images slider widget state
class PersonImagesSliderPageState extends State<PersonImagesSliderPage> {
  /// Page controller attached to the slider [PageView] widget
  late final PageController pageController;

  /// Indicates if saving image to device gallery is loading
  bool isLoadingImageSave = false;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initialImageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: widget.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: widget.images[index].imageUrl == null
                            ? Container()
                            : AppCachedNetworkImage(
                                key: ValueKey(
                                  '__person_image_slider_${index}__',
                                ),
                                imageUrl: widget.images[index].imageUrl!,
                                fit: BoxFit.fitWidth,
                                isLoaderShimmer: false,
                                alignment: Alignment.topCenter,
                              ),
                      ),
                    ),
                    if (widget.images[index].imageUrl != null)
                      PositionedDirectional(
                        top: 20,
                        end: 17,
                        child: SaveImageSliderAction(
                          imageUrl: widget.images[index].imageUrl!,
                        ),
                      ),
                  ],
                );
              },
            ),
            PositionedDirectional(
              bottom: 0,
              start: 20,
              child: SliderAction(
                key: const ValueKey('__slider_previous_button__'),
                icon: const Icon(Icons.arrow_back),
                onTap: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              end: 20,
              child: SliderAction(
                key: const ValueKey('__slider_next_button__'),
                icon: const Icon(Icons.arrow_forward),
                onTap: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
