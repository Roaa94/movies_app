import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/configs/styles/app_themes.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpProviderApp(
    Widget widget, {
    List<Override> overrides = const [],
  }) {
    return pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: AppThemes.darkTheme,
          home: widget,
        ),
      ),
    );
  }
}
