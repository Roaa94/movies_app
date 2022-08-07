import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/providers/popular_people_count_provider.dart';
import 'package:movies_app/features/people/views/pages/popular_people_page.dart';

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

    final PopularPeoplePageState popularPeoplePageState =
        tester.state(find.byType(PopularPeoplePage));
    // Make sure the scroll controller has clients
    expect(popularPeoplePageState.scrollController.hasClients, isTrue);
    popularPeoplePageState.scrollController.jumpTo(300);

    expect(popularPeoplePageState.scrollController.offset, equals(300));

    final appBarTitleGestureDetectorFinder =
        find.byKey(const ValueKey('__app_bar_title_gesture_detector__'));
    expect(appBarTitleGestureDetectorFinder, findsOneWidget);

    await tester.tap(appBarTitleGestureDetectorFinder);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(popularPeoplePageState.scrollController.offset, equals(0));
  });
}
