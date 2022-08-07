import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/current_popular_person_provider.dart';
import 'package:movies_app/features/people/views/pages/person_details_page.dart';
import 'package:movies_app/features/people/views/widgets/popular_person_list_item.dart';

import '../../../../test-utils/dummy-data/dummy_people.dart';
import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets(
    'renders ErrorView on FormatException',
    (WidgetTester tester) async {
      await tester.pumpProviderApp(
        const PopularPersonListItem(),
        overrides: [
          currentPopularPersonProvider.overrideWithValue(
            const AsyncValue.error(FormatException()),
          ),
        ],
      );

      await tester.pumpAndSettle();
      expect(find.byType(ErrorView), findsOneWidget);
    },
  );

  testWidgets('renders person data', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      const Material(
        child: PopularPersonListItem(),
      ),
      overrides: [
        currentPopularPersonProvider.overrideWithValue(
          AsyncValue.data(Person.fromJson(DummyPeople.rawPerson1)),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text(DummyPeople.person1.name), findsOneWidget);
  });

  testWidgets('navigates to person details page', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      const Material(
        child: PopularPersonListItem(),
      ),
      overrides: [
        currentPopularPersonProvider.overrideWithValue(
          AsyncValue.data(Person.fromJson(DummyPeople.rawPerson1)),
        ),
      ],
    );

    await tester.pumpAndSettle();
    final inkWell = find.byType(InkWell);

    expect(inkWell, findsOneWidget);

    await tester.tap(inkWell);
    await tester.pumpAndSettle();

    expect(find.byType(PersonDetailsPage), findsOneWidget);
  });
}
