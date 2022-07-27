import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';

class AppBarLeading extends StatelessWidget {
  const AppBarLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Material(
          color: AppColors.primary,
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
    );
  }
}
