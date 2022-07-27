import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/person_details_provider.dart';

class PersonDetailsPage extends ConsumerWidget {
  const PersonDetailsPage({
    Key? key,
    required this.personId,
    required this.personName,
  }) : super(key: key);

  final String personName;
  final int personId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Person> personAsync =
        ref.watch(personDetailsProvider(personId));

    return Scaffold(
      appBar: AppBar(
        title: Text(personName),
      ),
      body: personAsync.when(
        data: (Person person) {
          return Center(
            child: Text(person.biography ?? 'Person bio is empty'),
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching person details');
          log(error.toString());
          return const Icon(Icons.error);
        },
        loading: () => const AppLoader(),
      ),
    );
  }
}
