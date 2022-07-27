import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';

final personDetailsProvider = FutureProvider.family<Person, int>(
  (ref, personId) async {
    final peopleRepository = ref.watch(peopleRepositoryProvider);

    return await peopleRepository.getPersonDetails(personId);
  },
);
