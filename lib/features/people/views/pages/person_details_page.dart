import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/features/people/enums/gender.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/person_details_provider.dart';
import 'package:movies_app/features/people/views/widgets/person_details_sliver_app_bar.dart';
import 'package:movies_app/features/people/views/widgets/person_info.dart';
import 'package:movies_app/features/people/views/widgets/person_name.dart';

class PersonDetailsPage extends ConsumerWidget {
  const PersonDetailsPage({
    Key? key,
    required this.personId,
    required this.personName,
    required this.personAvatar,
    required this.personGender,
  }) : super(key: key);

  final String personName;
  final String? personAvatar;
  final int personId;
  final Gender personGender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Person> personAsync =
        ref.watch(personDetailsProvider(personId));

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
                      Center(
                        child: Text(person.biography ?? 'Person bio is empty'),
                      ),
                    ],
                  );
                },
                error: (Object error, StackTrace? stackTrace) {
                  log('Error fetching person details');
                  log(error.toString());
                  return const Icon(Icons.error);
                },
                loading: () => const AppLoader(),
              ),
              Container(
                height: 1000,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
