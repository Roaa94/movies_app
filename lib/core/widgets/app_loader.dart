import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      backgroundColor: Colors.black12,
    );
  }
}
