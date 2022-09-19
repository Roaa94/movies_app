import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/people/views/pages/person_details_page.dart';
import 'package:widgetbook/widgetbook.dart';

import '../test/test-utils/dummy-data/dummy_people.dart';

class WidgetbookHotReload extends StatelessWidget {
  const WidgetbookHotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
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
          data: ThemeData.light(),
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData.dark(),
        ),
      ],
    );
  }
}
