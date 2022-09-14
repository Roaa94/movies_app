import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';

/// Future provider that fetches a person's details
/// from the person's id
///
/// See: https://developers.themoviedb.org/3/people/get-person-details
final personDetailsProvider = FutureProvider.family<Person, int>(
  (ref, personId) async {
    final peopleRepository = ref.watch(peopleRepositoryProvider);
    final tmdbConfigs = await ref.watch(tmdbConfigsProvider.future);

    return peopleRepository.getPersonDetails(
      personId,
      imageConfigs: tmdbConfigs.images,
    );
  },
);
