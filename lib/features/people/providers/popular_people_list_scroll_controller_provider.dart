import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Scroll controller attached to the [ListView] widget of the
/// popular people list
///
/// Accessed in PopularPeopleAppBar to scroll to top
final popularPeopleScrollControllerProvider = Provider<ScrollController>((ref) {
  final scrollController = ScrollController();
  ref.onDispose(scrollController.dispose);
  return scrollController;
});
