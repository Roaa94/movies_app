import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/configs/styles/app_themes.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/features/people/views/pages/popular_people_page.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';

/// Main App Widget
class MoviesApp extends ConsumerWidget {
  /// Creates new instance of [MoviesApp]
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configsAsync = ref.watch(tmdbConfigsProvider);

    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: configsAsync.when(
        data: (TMDBConfigs tmdbConfigs) {
          return const PopularPeoplePage();
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching configurations');
          log(error.toString());
          log(stackTrace.toString());
          return const Scaffold(body: ErrorView());
        },
        loading: () => const Scaffold(body: AppLoader()),
      ),
    );
  }
}
