import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/providers/scroll_controller_provider.dart';

void main() {
  test('scrollcontroller is called properly', () {
    final container = ProviderContainer();

    final scrollController = container.read(scrollControllerProvider);

    expect(scrollController, isA<ScrollController>());
  });
}
