import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/features/people/views/pages/popular_people_page.dart';
import 'package:movies_app/features/tmdb-configs/repositories/tmdb_configs_repository.dart';
import 'package:movies_app/movies_app.dart';

import 'test-utils/dummy-data/dummy_configs.dart';
import 'test-utils/mocks.dart';

void main() {
  final TMDBConfigsRepository mockTMDBConfigsRepository =
      MockTMDBConfigsRepository();

  testWidgets('renders ErrorView for request error',
      (WidgetTester tester) async {
    when(() => mockTMDBConfigsRepository.get(forceRefresh: false))
        .thenThrow('An Error Occurred!');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Replace the TMDB Configs repository with the Mock Repository
          tmdbConfigsRepositoryProvider
              .overrideWithValue(mockTMDBConfigsRepository),
        ],
        child: const MoviesApp(),
      ),
    );

    // Initially loading
    expect(find.byType(AppLoader), findsOneWidget);

    // Re-render to make sure fetching is finished
    await tester.pumpAndSettle();

    // Shows error view
    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets(
    'renders PopularPeoplePage widget on request success',
    (WidgetTester tester) async {
      when(() => mockTMDBConfigsRepository.get(forceRefresh: false))
          .thenAnswer((_) async => DummyConfigs.tmdbConfigs);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Replace the TMDB Configs repository with the Mock Repository
            tmdbConfigsRepositoryProvider
                .overrideWithValue(mockTMDBConfigsRepository),
          ],
          child: const MoviesApp(),
        ),
      );

      // Initially loading
      expect(find.byType(AppLoader), findsOneWidget);

      // Re-render to make sure fetching is finished
      await tester.pumpAndSettle();

      expect(find.byType(PopularPeoplePage), findsOneWidget);
    },
  );
}
