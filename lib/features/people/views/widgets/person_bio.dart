import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';

/// Widget for a Person Biography
class PersonBio extends StatelessWidget {
  /// Creates a new instance of [PersonBio]
  const PersonBio(
    this.biography, {
    super.key,
  });

  /// Person biography text
  final String? biography;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
        child: Container(
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsetsDirectional.only(
            start: 40,
            end: 17,
            top: 30,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Biography',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 20),
              Text(
                biography ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
