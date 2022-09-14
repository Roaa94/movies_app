import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/ui_constants.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/enums/gender.dart';

class PersonCover extends StatelessWidget {
  const PersonCover(
    this.coverUrl, {
    Key? key,
    this.gender = Gender.unknown,
    this.height = UIConstants.personListItemHeight,
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
              fit: BoxFit.cover,
            )
          : AppCachedNetworkImage(
              imageUrl: coverUrl!,
            ),
    );
  }
}
