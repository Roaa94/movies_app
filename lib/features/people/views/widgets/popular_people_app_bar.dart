import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/people/providers/popular_people_list_scroll_controller_provider.dart';

/// AppBar widget for popular people page
class PopularPeopleAppBar extends ConsumerWidget {
  /// Creates a new instance of [PopularPeopleAppBar]
  const PopularPeopleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularPeopleScrollController =
        ref.watch(popularPeopleScrollControllerProvider);

    return GestureDetector(
      key: const ValueKey('__app_bar_title_gesture_detector__'),
      onTap: () => popularPeopleScrollController.animateTo(
        popularPeopleScrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: const Text('Popular'),
    );
  }
}
