import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/providers/person_images_provider.dart';
import 'package:movies_app/features/people/views/widgets/person_images.dart';
import 'package:movies_app/features/people/views/widgets/person_images_grid.dart';

import '../../../../test-utils/dummy-data/dummy_people.dart';
import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets('renders ErrorView on error', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      PersonImages(DummyPeople.person1.id!),
      overrides: [
        personImagesProvider(DummyPeople.person1.id!).overrideWithProvider(
          FutureProvider<List<PersonImage>>(
            (ref) => throw Exception(),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets('renders person images grid', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      PersonImages(DummyPeople.person1.id!),
      overrides: [
        personImagesProvider(DummyPeople.person1.id!).overrideWithProvider(
          FutureProvider<List<PersonImage>>(
            (ref) async => Future.value(DummyPeople.personImagesWithoutImages),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byType(PersonImagesGrid), findsOneWidget);
  });
}
