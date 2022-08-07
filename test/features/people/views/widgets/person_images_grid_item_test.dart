import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/views/widgets/person_images_grid_item.dart';

import '../../../../test-utils/dummy-data/dummy_people.dart';
import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets(
    'renders asset image for null thumbnail',
    (WidgetTester tester) async {
      await tester.pumpApp(
        PersonImagesGridItem(
            PersonImage.fromJson(DummyPeople.rawDummyPersonImage1)),
      );

      await tester.pumpAndSettle();
      expect(
        find.byType(AppCachedNetworkImage),
        findsNothing,
      );
    },
  );

  testWidgets(
    'renders network image for a thumbnail url',
    (WidgetTester tester) async {
      await tester.pumpApp(
        PersonImagesGridItem(DummyPeople.dummyPersonImage1),
      );

      await tester.pump();
      expect(
        find.byType(AppCachedNetworkImage),
        findsOneWidget,
      );
    },
  );
}
