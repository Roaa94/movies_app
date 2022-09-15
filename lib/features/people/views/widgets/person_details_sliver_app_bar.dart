import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/app_bar_leading.dart';
import 'package:movies_app/features/people/enums/gender.dart';
import 'package:movies_app/features/people/views/widgets/person_cover.dart';

/// Person details page Sliver AppBar widget
class PersonDetailsSliverAppBar extends StatelessWidget {
  /// Creates a new instance of [PersonDetailsSliverAppBar]
  const PersonDetailsSliverAppBar({
    Key? key,
    this.avatar,
    this.gender = Gender.unknown,
    required this.personId,
  }) : super(key: key);

  /// Id of the person being previewed
  final int personId;

  /// Avatar of the person
  /// used for the Hero animation
  final String? avatar;

  /// Gender of the person
  ///
  /// This is used to show female/male/unknown placeholder images:
  /// assets/images/placeholder-female.png
  /// assets/images/placeholder-male.png
  /// assets/images/placeholder-unknown.png
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.35,
      collapsedHeight: 100,
      leadingWidth: 70,
      backgroundColor: Colors.transparent,
      leading: const AppBarLeading(),
      pinned: true,
      flexibleSpace: Padding(
        padding: const EdgeInsetsDirectional.only(start: 40),
        child: Hero(
          tag: 'person_${personId}_profile_picture',
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
            ),
            child: PersonCover(
              avatar,
              gender: gender,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
