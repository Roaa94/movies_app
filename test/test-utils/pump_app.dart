import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/configs/styles/app_themes.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
      Widget widget, NavigatorObserver navigatorObserver) async {
    return pumpWidget(
      MaterialApp(
        home: widget,
        navigatorObservers: [navigatorObserver],
      ),
    );
  }

  Future<void> pumpProviderApp(
    Widget widget, {
    List<Override> overrides = const [],
  }) async {
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
