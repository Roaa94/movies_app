import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/views/widgets/person_cover.dart';

import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets(
    'renders asset image for null cover url',
    (WidgetTester tester) async {
      await tester.pumpApp(
        const PersonCover(null),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(AppCachedNetworkImage),
        findsNothing,
      );
    },
  );

  testWidgets(
    'renders network image for a cover url',
    (WidgetTester tester) async {
      await tester.pumpApp(
        const PersonCover('avatar_url'),
      );

      await tester.pump();

      expect(
        find.byType(AppCachedNetworkImage),
        findsOneWidget,
      );
    },
  );
}
