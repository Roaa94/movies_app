import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/core/widgets/list_item_shimmer.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/current_popular_person_provider.dart';
import 'package:movies_app/features/people/providers/paginated_popular_people_provider.dart';
import 'package:movies_app/features/people/providers/popular_people_count_provider.dart';
import 'package:movies_app/features/people/providers/scroll_controller_provider.dart';
import 'package:movies_app/features/people/views/widgets/popular_person_list_item.dart';

class PopularPeopleList extends ConsumerWidget {
  const PopularPeopleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularPeopleCount = ref.watch(popularPeopleCountProvider);
    final scrollController = ref.watch(scrollControllerProvider);

    return popularPeopleCount.when(
      loading: () => const ListItemShimmer(),
      data: (int count) {
        return ListView.builder(
          controller: scrollController,
          itemCount: count,
          itemExtent: 110,
          itemBuilder: (context, index) {
            final AsyncValue<Person> currentPopularPersonFromIndex = ref
                .watch(paginatedPopularPeopleProvider(index ~/ 20))
                .whenData((pageData) => pageData.results[index % 20]);

            return ProviderScope(
              overrides: [
                currentPopularPersonProvider
                    .overrideWithValue(currentPopularPersonFromIndex)
              ],
              child: const PopularPersonListItem(),
            );
          },
        );
      },
      error: (Object error, StackTrace? stackTrace) {
        log('Error fetching popular people');
        log(error.toString());
        return const ErrorView();
      },
    );
  }
}
