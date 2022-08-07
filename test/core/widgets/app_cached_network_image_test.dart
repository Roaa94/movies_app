import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/widgets/app_cached_network_image.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/core/widgets/shimmer.dart';

import '../../test-utils/pump_app.dart';

// Todo: test error widget
void main() {
  testWidgets('shows loading widget', (WidgetTester tester) async {
    await tester.pumpApp(
      const AppCachedNetworkImage(
        imageUrl: 'image_url',
        isLoaderShimmer: false,
      ),
    );

    await tester.pump();
    expect(find.byType(AppLoader), findsOneWidget);
  });

  testWidgets('shows shimmer widget', (WidgetTester tester) async {
    await tester.pumpApp(
      const AppCachedNetworkImage(
        imageUrl: 'image_url',
        isLoaderShimmer: true,
      ),
    );

    await tester.pump();
    expect(find.byType(Shimmer), findsOneWidget);
  });
}
