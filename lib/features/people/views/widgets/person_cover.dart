import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/enums/gender.dart';

class PersonCover extends StatelessWidget {
  const PersonCover(
    this.coverUrl, {
    Key? key,
    this.gender = Gender.unknown,
    this.height = 110,
  }) : super(key: key);

  final String? coverUrl;
  final Gender gender;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: coverUrl == null
          ? Image.asset(
              'assets/images/placeholder-${gender.name}.png',
              key: const ValueKey('__person_cover_asset__'),
              fit: BoxFit.cover,
            )
          : AppCachedNetworkImage(
              key: const ValueKey('__person_cover_network__'),
              imageUrl: coverUrl!,
            ),
    );
  }
}
