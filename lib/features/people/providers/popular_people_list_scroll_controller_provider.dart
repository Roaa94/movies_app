import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularPeopleScrollControllerProvider = Provider<ScrollController>((ref) {
  final scrollController = ScrollController();
  ref.onDispose(scrollController.dispose);
  return scrollController;
});
