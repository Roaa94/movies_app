import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/views/widgets/slider_action.dart';

class PersonImagesSliderPage extends StatefulWidget {
  const PersonImagesSliderPage({
    Key? key,
    this.initialImageIndex = 0,
    required this.images,
  }) : super(key: key);

  final int initialImageIndex;
  final List<PersonImage> images;

  @override
  State<PersonImagesSliderPage> createState() => _PersonImagesSliderPageState();
}

class _PersonImagesSliderPageState extends State<PersonImagesSliderPage> {
  late final PageController pageController;

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
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: widget.images[index].imageUrl == null
                      ? Container()
                      : AppCachedNetworkImage(
                          imageUrl: widget.images[index].imageUrl!,
                          fit: BoxFit.fitWidth,
                          isLoaderShimmer: false,
                        ),
                );
              },
            ),
            PositionedDirectional(
              bottom: 0,
              start: 20,
              child: SliderAction(
                icon: Icons.arrow_back,
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
                icon: Icons.arrow_forward,
                onTap: () {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              start: 0,
              end: 0,
              child: SliderAction(
                icon: Icons.download,
                onTap: () {
                  // Save image to device
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
