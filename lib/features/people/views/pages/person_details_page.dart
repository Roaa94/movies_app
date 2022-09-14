import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/features/media/models/media.dart';
import 'package:movies_app/features/people/enums/gender.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/person_details_provider.dart';
import 'package:movies_app/features/people/views/widgets/person_bio.dart';
import 'package:movies_app/features/people/views/widgets/person_details_sliver_app_bar.dart';
import 'package:movies_app/features/people/views/widgets/person_images.dart';
import 'package:movies_app/features/people/views/widgets/person_info.dart';
import 'package:movies_app/features/people/views/widgets/person_media.dart';
import 'package:movies_app/features/people/views/widgets/person_name.dart';

/// Page widget of the Person details
class PersonDetailsPage extends ConsumerWidget {
  /// Creates new instance of [PersonDetailsPage]
  const PersonDetailsPage({
    Key? key,
    required this.personId,
    required this.personName,
    required this.personAvatar,
    required this.personGender,
    this.personMedia = const [],
  }) : super(key: key);

  /// Person name
  final String personName;

  /// Person avatar url
  final String? personAvatar;

  /// Person id
  final int personId;

  /// Person gender
  final Gender personGender;

  /// Person media list (from knownFor)
  final List<Media> personMedia;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personAsync = ref.watch(personDetailsProvider(personId));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PersonDetailsSliverAppBar(
            personId: personId,
            avatar: personAvatar,
            gender: personGender,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              PersonName(personName),
              personAsync.when(
                data: (Person person) {
                  return Column(
                    children: [
                      PersonInfo(person),
                      PersonMedia(personMedia),
                      PersonImages(personId),
                      PersonBio(person.biography),
                      SizedBox(
                        height: 20 + MediaQuery.of(context).padding.bottom,
                      ),
                    ],
                  );
                },
                error: (Object error, StackTrace? stackTrace) {
                  log('Error fetching person details');
                  log(error.toString());
                  return const ErrorView();
                },
                loading: () => const AppLoader(),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
