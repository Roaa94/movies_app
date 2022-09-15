import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';
import 'package:movies_app/features/people/models/person.dart';

/// Person information widget
///
/// Contains person department and birthday info
class PersonInfo extends StatelessWidget {
  /// Creates a new instance of [PersonInfo]
  const PersonInfo(
    this.person, {
    Key? key,
  }) : super(key: key);

  /// Person object
  final Person person;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
        child: Container(
          padding: const EdgeInsetsDirectional.only(
            start: 40,
            end: 17,
            bottom: 20,
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Row(
            children: [
              if (person.knownForDepartment != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Known For',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white.withOpacity(0.5),
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        person.knownForDepartment!,
                        style: Theme.of(context).primaryTextTheme.headline4,
                      ),
                    ],
                  ),
                ),
              if (person.birthday != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Birthday',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white.withOpacity(0.5),
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        DateFormat('dd-MM-yyyy').format(person.birthday!),
                        style: Theme.of(context).primaryTextTheme.headline4,
                      ),
                    ],
                  ),
                ),
              // Expanded(),
            ],
          ),
        ),
      ),
    );
  }
}
