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
              fit: BoxFit.cover,
              height: 70,
            )
          : AppCachedNetworkImage(
              imageUrl: avatarUrl!,
              height: 70,
            ),
    );
  }
}
