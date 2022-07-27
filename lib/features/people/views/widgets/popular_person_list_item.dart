import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/core/widgets/list_item_shimmer.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/current_popular_person_provider.dart';
import 'package:movies_app/features/people/views/pages/person_details_page.dart';

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
                  if (person.avatar != null)
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AppCachedNetworkImage(
                          imageUrl: person.avatar!,
                          height: 70,
                        ),
                      ),
                    ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person.name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
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
          return const Icon(Icons.error);
        },
        loading: () => const ListItemShimmer(),
      ),
    );
  }
}
