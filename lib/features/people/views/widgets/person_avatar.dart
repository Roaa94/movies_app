import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/enums/gender.dart';

/// Avatar widget for person
class PersonAvatar extends StatelessWidget {
  /// Creates a new instance of [PersonAvatar]
  const PersonAvatar(
    this.avatarUrl, {
    super.key,
    this.gender = Gender.unknown,
  });

  /// Image url of person avatar
  final String? avatarUrl;

  /// Gender of the person
  ///
  /// This is used to show female/male/unknown placeholder images:
  /// assets/images/placeholder-female.png
  /// assets/images/placeholder-male.png
  /// assets/images/placeholder-unknown.png
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: avatarUrl == null
          ? Image.asset(
              'assets/images/placeholder-${gender.name}.png',
              fit: BoxFit.cover,
              height: 90,
            )
          : AppCachedNetworkImage(
              imageUrl: avatarUrl!,
              height: 90,
            ),
    );
  }
}
