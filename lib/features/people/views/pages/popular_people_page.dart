import 'package:flutter/material.dart';
import 'package:movies_app/features/people/views/widgets/popular_people_list.dart';

class PopularPeoplePage extends StatefulWidget {
  const PopularPeoplePage({Key? key}) : super(key: key);

  @override
  State<PopularPeoplePage> createState() => PopularPeoplePageState();
}

class PopularPeoplePageState extends State<PopularPeoplePage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          key: const ValueKey('__app_bar_title_gesture_detector__'),
          onTap: () => scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: const Text('Popular'),
        ),
      ),
      body: PopularPeopleList(scrollController: scrollController),
    );
  }
}
