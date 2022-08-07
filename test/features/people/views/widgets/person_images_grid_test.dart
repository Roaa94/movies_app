import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/views/pages/person_images_slider_page.dart';
import 'package:movies_app/features/people/views/widgets/person_images_grid.dart';

import '../../../../test-utils/dummy-data/dummy_people.dart';
import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets(
    'navigates to PersonImagesSliderPage',
    (WidgetTester tester) async {
      await tester.pumpApp(
        PersonImagesGrid(DummyPeople.personImagesWithoutImages),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      expect(find.byType(PersonImagesSliderPage), findsOneWidget);
    },
  );
}
