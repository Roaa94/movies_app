import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';


/// FutureProvider that fetches a person's images
///
/// See: https://developers.themoviedb.org/3/people/get-person-images
final personImagesProvider =
    FutureProvider.family<List<PersonImage>, int>((ref, personId) async {
  final peopleRepository = ref.watch(peopleRepositoryProvider);
  final tmdbConfigs = await ref.watch(tmdbConfigsProvider.future);

  return peopleRepository.getPersonImages(
    personId,
    imageConfigs: tmdbConfigs.images,
  );
});
