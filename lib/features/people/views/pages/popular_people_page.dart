import 'package:flutter/material.dart';
import 'package:movies_app/features/people/views/widgets/popular_people_list.dart';
import 'package:movies_app/features/people/views/widgets/popular_person_app_bar.dart';

class PopularPeoplePage extends StatelessWidget {
  const PopularPeoplePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PopularPeopleAppBar(),
      ),
      body: const PopularPeopleList(),
    );
  }
}
