import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';

final personDetailsProvider = FutureProvider.family<Person, int>(
  (ref, personId) async {
    final peopleRepository = ref.watch(peopleRepositoryProvider);
    final tmdbConfigs = await ref.watch(tmdbConfigsProvider.future);

    return await peopleRepository.getPersonDetails(
      personId,
      imageConfigs: tmdbConfigs.images,
    );
  },
);
