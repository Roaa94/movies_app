import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/providers/popular_people_list_scroll_controller_provider.dart';

void main() {
  test('popularPeopleScrollControllerProvider is a ScrollController', () {
    final container = ProviderContainer();

    final scrollController = container.read(popularPeopleScrollControllerProvider);

    expect(scrollController, isA<ScrollController>());
  });
}
