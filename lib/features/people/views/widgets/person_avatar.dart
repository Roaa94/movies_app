import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/enums/gender.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar(
    this.avatarUrl, {
    Key? key,
    this.gender = Gender.unknown,
  }) : super(key: key);

  final String? avatarUrl;
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: avatarUrl == null
          ? Image.asset(
              'assets/images/placeholder-${gender.name}.png',
              key: const ValueKey('__person_avatar_asset__'),
              fit: BoxFit.cover,
              height: 90,
            )
          : AppCachedNetworkImage(
              key: const ValueKey('__person_avatar_network__'),
              imageUrl: avatarUrl!,
              height: 90,
            ),
    );
  }
}
