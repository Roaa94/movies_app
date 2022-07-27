import 'package:flutter/material.dart';
import 'package:movies_app/features/people/views/widgets/popular_people_list.dart';

class PopularPeoplePage extends StatefulWidget {
  const PopularPeoplePage({Key? key}) : super(key: key);

  @override
  State<PopularPeoplePage> createState() => _PopularPeoplePageState();
}

class _PopularPeoplePageState extends State<PopularPeoplePage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: scrollController.hasClients
              ? () => scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )
              : null,
          child: const Text('Popular'),
        ),
      ),
      body: PopularPeopleList(scrollController: scrollController),
    );
  }
}
