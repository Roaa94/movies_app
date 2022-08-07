import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/views/widgets/person_avatar.dart';

import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets(
    'renders asset image for null avatarUrl',
    (WidgetTester tester) async {
      await tester.pumpApp(
        const PersonAvatar(null),
      );

      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('__person_avatar_asset__')),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'renders network image for an avatarUrl',
    (WidgetTester tester) async {
      await tester.pumpApp(
        const PersonAvatar('avatar_url'),
      );

      await tester.pump();
      expect(
        find.byKey(const ValueKey('__person_avatar_asset__')),
        findsNothing,
      );

      expect(
        find.byKey(const ValueKey('__person_avatar_network__')),
        findsOneWidget,
      );
    },
  );
}
