import 'package:flutter/material.dart';

/// Default error view widget
class ErrorView extends StatelessWidget {
  /// Creates a new instance of [ErrorView]
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.error, size: 40),
    );
  }
}
