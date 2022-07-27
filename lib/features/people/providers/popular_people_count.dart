import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/people/providers/popular_people_provider.dart';

final popularPeopleCountProvider = Provider<AsyncValue<int>>((ref) {
  return ref
      .watch(paginatedPopularPeopleProvider(0))
      .whenData((pageData) => pageData.totalResults);
});