import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/widgets/app_loader.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/features/people/views/pages/popular_people_page.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_image_configs_provider.dart';

class MoviesApp extends ConsumerWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configsAsync = ref.watch(tmdbConfigsProvider);

    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: configsAsync.when(
        data: (TMDBConfigs tmdbConfigs) {
          return ProviderScope(
            overrides: [
              tmdbImageConfigsProvider.overrideWithValue(tmdbConfigs.images),
            ],
            child: const PopularPeoplePage(),
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching popular people');
          log(error.toString());
          return const Scaffold(body: ErrorView());
        },
        loading: () => const Scaffold(body: AppLoader()),
      ),
    );
  }
}
