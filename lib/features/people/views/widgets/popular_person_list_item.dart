import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/current_popular_person_provider.dart';

class PopularPersonListItem extends ConsumerWidget {
  const PopularPersonListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Person> personAsync =
        ref.watch(currentPopularPersonProvider);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 10,
      ),
      child: personAsync.when(
        data: (Person person) {
          return Row(
            children: [
              // Avatar
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(person.name),
                    const Text('Subtitle'),
                  ],
                ),
              ),
            ],
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching current popular person');
          log(error.toString());
          if(error is FormatException) {
            log('Format Exception: ${error.source}');
          }
          return const Icon(Icons.error);
        },
        loading: () => const AppLoader(),
      ),
    );
  }
}
