import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/providers/popular_people_count_provider.dart';
import 'package:movies_app/features/people/providers/popular_people_list_scroll_controller_provider.dart';
import 'package:movies_app/features/people/views/pages/popular_people_page.dart';
import 'package:movies_app/features/people/views/widgets/popular_person_app_bar.dart';

import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets('can scroll to top', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      const PopularPeoplePage(),
      overrides: [
        popularPeopleCountProvider.overrideWithValue(
          const AsyncValue.data(20),
        ),
      ],
    );

    await tester.pumpAndSettle();

    final ref = tester
        .element<ConsumerStatefulElement>(find.byType(PopularPeopleAppBar));

    final scrollController = ref.watch(popularPeopleScrollControllerProvider);

    // Make sure the scroll controller has clients
    expect(scrollController.hasClients, isTrue);
    scrollController.jumpTo(300);

    expect(scrollController.offset, equals(300));

    final appBarTitleGestureDetectorFinder =
        find.byKey(const ValueKey('__app_bar_title_gesture_detector__'));
    expect(appBarTitleGestureDetectorFinder, findsOneWidget);

    await tester.tap(appBarTitleGestureDetectorFinder);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(scrollController.offset, equals(0));
  });
}
