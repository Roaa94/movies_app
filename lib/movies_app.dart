import 'package:flutter/material.dart';
import 'package:movies_app/features/people/views/pages/popular_people_page.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PopularPeoplePage(),
    );
  }
}
