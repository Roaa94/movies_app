import 'package:flutter/material.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        //
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(),
    );
  }
}
