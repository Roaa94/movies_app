import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/configs/styles/app_themes.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/providers/person_details_provider.dart';
import 'package:movies_app/features/people/providers/person_images_provider.dart';
import 'package:movies_app/features/people/views/pages/person_details_page.dart';
import 'package:movies_app/features/tmdb-configs/models/tmdb_configs.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';
import 'package:widgetbook/widgetbook.dart';

import '../test/test-utils/dummy-data/dummy_configs.dart';
import '../test/test-utils/dummy-data/dummy_people.dart';

class WidgetbookHotReload extends StatelessWidget {
  const WidgetbookHotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'material',
          folders: [
            WidgetbookFolder(
              name: 'Pages',
              widgets: [
                WidgetbookComponent(
                  name: 'Person Details',
                  useCases: [
                    WidgetbookUseCase(
                      name: '',
                      builder: (context) {
                        return ProviderScope(
                          overrides: [
                            tmdbConfigsProvider.overrideWithValue(
                              const AsyncValue<TMDBConfigs>.data(
                                DummyConfigs.tmdbConfigs,
                              ),
                            ),
                            personDetailsProvider(DummyPeople.person1.id!)
                                .overrideWithValue(
                              AsyncValue<Person>.data(
                                DummyPeople.person1,
                              ),
                            ),
                            personImagesProvider(DummyPeople.person1.id!)
                                .overrideWithValue(
                              AsyncValue<List<PersonImage>>.data(
                                DummyPeople.personImages,
                              ),
                            ),
                          ],
                          child: MaterialApp(
                            home: PersonDetailsPage(
                              personId: DummyPeople.person1.id!,
                              personName: DummyPeople.person1.name,
                              personAvatar: null,
                              personGender: DummyPeople.person1.gender,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
          widgets: [
            WidgetbookComponent(
              name: 'FAB',
              useCases: [
                WidgetbookUseCase(
                  name: 'Icon',
                  builder: (context) {
                    return FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.add),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      appInfo: AppInfo(name: 'movies_app'),
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: AppThemes.darkTheme,
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: AppThemes.darkTheme,
        ),
      ],
    );
  }
}
