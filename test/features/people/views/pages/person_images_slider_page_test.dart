import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movies_app/features/people/views/pages/person_images_slider_page.dart';

import '../../../../test-utils/dummy-data/dummy_people.dart';
import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets('defaults to passed initial page', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      PersonImagesSliderPage(
        images: DummyPeople.personImages,
        initialImageIndex: 1,
      ),
    );

    await tester.pump();

    // ignore: omit_local_variable_types
    final PersonImagesSliderPageState personImagesSliderPageState =
        tester.state(find.byType(PersonImagesSliderPage));

    expect(personImagesSliderPageState.pageController.initialPage, equals(1));
    expect(personImagesSliderPageState.pageController.page, equals(1));

    expect(
      find.byKey(const ValueKey('__person_image_slider_1__')),
      findsOneWidget,
    );
  });

  testWidgets('can go to next slide', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await tester.pumpProviderApp(
        PersonImagesSliderPage(
          images: DummyPeople.personImages,
        ),
      );
    });

    await tester.pump();
    // ignore: omit_local_variable_types
    PersonImagesSliderPageState personImagesSliderPageState =
        tester.state(find.byType(PersonImagesSliderPage));
    expect(personImagesSliderPageState.pageController.page, equals(0));

    await tester.tap(
      find.byKey(
        const ValueKey('__slider_next_button__'),
      ),
    );

    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    personImagesSliderPageState =
        tester.state(find.byType(PersonImagesSliderPage));
    expect(personImagesSliderPageState.pageController.page, equals(1));
  });

  testWidgets('defaults to passed initial page', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      PersonImagesSliderPage(
        images: DummyPeople.personImages,
        initialImageIndex: 1,
      ),
    );

    await tester.pump();

    // ignore: omit_local_variable_types
    final PersonImagesSliderPageState personImagesSliderPageState =
        tester.state(find.byType(PersonImagesSliderPage));

    expect(personImagesSliderPageState.pageController.initialPage, equals(1));
    expect(personImagesSliderPageState.pageController.page, equals(1));

    expect(
      find.byKey(const ValueKey('__person_image_slider_1__')),
      findsOneWidget,
    );
  });

  testWidgets('can go to previous slide', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await tester.pumpProviderApp(
        PersonImagesSliderPage(
          images: DummyPeople.personImages,
          initialImageIndex: 1,
        ),
      );
    });

    await tester.pump();

    // ignore: omit_local_variable_types
    PersonImagesSliderPageState personImagesSliderPageState =
        tester.state(find.byType(PersonImagesSliderPage));
    expect(personImagesSliderPageState.pageController.page, equals(1));

    await tester.tap(
      find.byKey(
        const ValueKey('__slider_previous_button__'),
      ),
    );

    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    personImagesSliderPageState =
        tester.state(find.byType(PersonImagesSliderPage));
    expect(personImagesSliderPageState.pageController.page, equals(0));
  });
}
