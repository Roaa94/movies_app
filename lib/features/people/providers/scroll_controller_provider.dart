import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scrollControllerProvider = Provider((ref) {
  final controller = ScrollController();
  ref.onDispose(controller.dispose);
  return controller;
});
