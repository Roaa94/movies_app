import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/features/people/providers/popular_people_count_provider.dart';
import 'package:movies_app/features/people/views/widgets/popular_people_list.dart';

import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets('Renders ErrorView on provider error',
      (WidgetTester tester) async {
    await tester.pumpProviderApp(
      const PopularPeopleList(),
      overrides: [
        popularPeopleCountProvider.overrideWithValue(
          const AsyncValue.error('Error getting popular people count!'),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byType(ErrorView), findsOneWidget);
  });
}
