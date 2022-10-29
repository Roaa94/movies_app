import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/ui_constants.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/enums/gender.dart';

/// Widget for a person cover image
class PersonCover extends StatelessWidget {
  /// Creates a new instance of [PersonCover]
  const PersonCover(
    this.coverUrl, {
    super.key,
    this.gender = Gender.unknown,
    this.height = UIConstants.personListItemHeight,
  });

  /// Cover image url
  final String? coverUrl;

  /// Gender of the person
  ///
  /// This is used to show female/male/unknown placeholder images:
  /// assets/images/placeholder-female.png
  /// assets/images/placeholder-male.png
  /// assets/images/placeholder-unknown.png
  final Gender gender;

  /// Cover image height
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: coverUrl == null
          ? Image.asset(
              'assets/images/placeholder-${gender.name}.png',
              fit: BoxFit.cover,
            )
          : AppCachedNetworkImage(
              imageUrl: coverUrl!,
            ),
    );
  }
}
