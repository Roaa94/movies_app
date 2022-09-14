import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/core/widgets/list_item_shimmer.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/current_popular_person_provider.dart';
import 'package:movies_app/features/people/views/pages/person_details_page.dart';
import 'package:movies_app/features/people/views/widgets/person_avatar.dart';

class PopularPersonListItem extends ConsumerWidget {
  const PopularPersonListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Person> personAsync =
        ref.watch(currentPopularPersonProvider);

    return Container(
      child: personAsync.when(
        data: (Person person) {
          return InkWell(
            onTap: person.id == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PersonDetailsPage(
                          personId: person.id!,
                          personName: person.name,
                          personAvatar: person.avatar,
                          personGender: person.gender,
                          personMedia: person.knownFor,
                        ),
                      ),
                    );
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
                vertical: 10,
              ),
              child: Row(
                children: [
                  // Avatar
                  Expanded(
                    flex: 1,
                    child: Hero(
                      tag: 'person_${person.id}_profile_picture',
                      child: PersonAvatar(
                        person.avatar,
                        gender: person.gender,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: Text(
                      person.name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching current popular person');
          log(error.toString());
          if (error is FormatException) {
            log('Format Exception: ${error.source}');
          }
          return const ErrorView();
        },
        loading: () => const ListItemShimmer(),
      ),
    );
  }
}
