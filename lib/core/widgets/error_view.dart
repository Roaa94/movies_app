import 'package:flutter/material.dart';

/// Default error view widget
class ErrorView extends StatelessWidget {
  /// Creates a new instance of [ErrorView]
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.error, size: 40),
    );
  }
}
