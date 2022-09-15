import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/people/models/person.dart';

/// The provider that provides the Person data for each list item
///
/// Initially it throws an UnimplementedError because we won't use it
/// before overriding it
///
/// For infinite scroll tutorial:
/// https://github.com/Roaa94/movies_app/tree/main#infinite-scroll-functionality
final currentPopularPersonProvider = Provider<AsyncValue<Person>>((ref) {
  throw UnimplementedError();
});
