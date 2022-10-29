import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/core/widgets/shimmer.dart';

/// Wrapper widget around a [CachedNetworkImage]
///
/// See: https://pub.dev/packages/cached_network_image
class AppCachedNetworkImage extends StatelessWidget {
  /// Creates a new instance of [AppCachedNetworkImage]
  const AppCachedNetworkImage({
    super.key,
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
  });

  /// The image url
  final String imageUrl;

  /// An optional custom error widget builder
  final LoadingErrorWidgetBuilder? customErrorWidgetBuilder;

  /// An optional custom error widget
  ///
  /// Default to an [ErrorView] widget
  final Widget? customErrorWidget;

  /// An optional custom loader widget
  ///
  /// Defaults to a [Shimmer] widget if [isLoaderShimmer] is true
  /// Defaults to a [AppLoader] widget if [isLoaderShimmer] is false
  final Widget? loaderWidget;

  /// Forces a null placeholder
  final bool noLoader;

  /// Image height
  final double? height;

  /// Image width
  final double? width;

  /// Image fit
  final BoxFit fit;

  /// Image alignment
  final Alignment alignment;

  /// Image overlay color
  final Color? color;

  /// Image overlay color blend mode
  final BlendMode? colorBlendMode;

  /// Indicates what loading widget to render
  ///
  /// [AppLoader] or [Shimmer]
  /// Defaults to true
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
              log('🖼 🖼 🖼 🖼 🖼 Error Fetching Image 🖼 🖼 🖼 🖼 🖼');
              log('Image url: $url');
              return customErrorWidget ?? const ErrorView();
            }, // coverage:ignore-end
      ),
    );
  }
}
