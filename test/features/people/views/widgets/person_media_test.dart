import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/views/widgets/person_media.dart';

import '../../../../test-utils/dummy-data/dummy_people.dart';
import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets('renders list of person media', (WidgetTester tester) async {
    await tester.pumpApp(
      PersonMedia(DummyPeople.popularPeople1[0].knownFor),
    );

    await tester.pump();
    expect(
      find.byType(AppCachedNetworkImage),
      findsNWidgets(DummyPeople.popularPeople1[0].knownFor.length),
    );
  });

  testWidgets(
    'renders list of person media without images when not available',
    (WidgetTester tester) async {
      await tester.pumpApp(
        PersonMedia(Person.fromJson(DummyPeople.rawPopularPeople1[0]).knownFor),
      );

      await tester.pump();
      expect(
        find.byType(AppCachedNetworkImage),
        findsNothing,
      );
    },
  );
}
