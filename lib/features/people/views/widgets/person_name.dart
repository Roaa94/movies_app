import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';

/// Widget for a person name with adaptive text size
class PersonName extends StatelessWidget {
  /// Creates a new instance of [PersonName]
  const PersonName(
    this.personName, {
    super.key,
  });

  /// Person name
  final String personName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 40,
        end: 100,
        top: 20,
        bottom: 15,
      ),
      child: Text(
        personName,
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: personName.length > 10 ? 40 : 60,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
      ),
    );
  }
}
