import 'package:flutter/material.dart';

/// Default loading widget with an adaptive [CircularProgressIndicator]
class AppLoader extends StatelessWidget {
  /// Creates a new instance of [AppLoader]
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
