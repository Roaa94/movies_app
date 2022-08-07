import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/services/media/media_service.dart';
import 'package:movies_app/features/people/views/widgets/save_image_slider_action.dart';
import 'package:movies_app/features/people/views/widgets/slider_action.dart';

import '../../../../test-utils/mocks.dart';
import '../../../../test-utils/pump_app.dart';

void main() {
  final mockMediaServiceProvider = MockMediaServiceProvider();

  testWidgets('can save image to gallery', (WidgetTester tester) async {
    when(() => mockMediaServiceProvider.saveNetworkImageToGallery('image_url'))
        .thenAnswer((_) async {});

    await tester.pumpProviderApp(
      const Scaffold(
        body: SaveImageSliderAction(imageUrl: 'image_url'),
      ),
      overrides: [
        mediaServiceProvider.overrideWithValue(mockMediaServiceProvider),
      ],
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byType(SliderAction));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
