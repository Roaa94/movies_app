import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/widgets/app_bar_leading.dart';

import '../../test-utils/mocks.dart';
import '../../test-utils/pump_app.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockRoute());
  });

  testWidgets('can pop', (WidgetTester tester) async {
    final mockNavigatorObserver = MockNavigatorObserver();

    await tester.pumpApp(
      const AppBarLeading(),
      mockNavigatorObserver,
    );

    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    await tester.tap(find.byType(InkWell));
    verify(() => mockNavigatorObserver.didPop(any(), any()));
  });
}
