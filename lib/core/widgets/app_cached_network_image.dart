import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/core/widgets/shimmer.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.customErrorWidgetBuilder,
    this.noLoader = false,
    this.customErrorWidget,
    this.loaderWidget,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.isLoaderShimmer = true,
  }) : super(key: key);

  final String imageUrl;
  final LoadingErrorWidgetBuilder? customErrorWidgetBuilder;
  final Widget? customErrorWidget;
  final Widget? loaderWidget;
  final bool noLoader;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Alignment alignment;
  final Color? color;
  final BlendMode? colorBlendMode;
  final bool isLoaderShimmer;

  @override
  Widget build(BuildContext context) {
    final memCacheHeight = height != null ? (height! * 2).ceil() : null;
    final memCacheWidth = width != null ? (width! * 2).ceil() : null;
    return RepaintBoundary(
      child: CachedNetworkImage(
        placeholder: noLoader
            ? null
            : (_, __) => Center(
                  child: loaderWidget ??
                      (isLoaderShimmer
                          ? Shimmer(
                              height: height,
                              width: width,
                            )
                          : const AppLoader()),
                ),
        memCacheHeight: memCacheHeight,
        memCacheWidth: memCacheWidth,
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        colorBlendMode: colorBlendMode,
        alignment: alignment,
        errorWidget: customErrorWidgetBuilder ??
            // Todo: test this
            // coverage:ignore-start
            (BuildContext context, String url, dynamic error) {
              log('🖼 🖼 🖼 🖼 🖼 🖼 🖼 🖼 Error Fetching Image 🖼 🖼 🖼 🖼 🖼 🖼 🖼 🖼');
              log('Image url: $url');
              return customErrorWidget ?? const ErrorView();
            }, // coverage:ignore-end
      ),
    );
  }
}
