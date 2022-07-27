import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';

class SliderAction extends StatelessWidget {
  const SliderAction({
    Key? key,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Material(
          color: AppColors.primary,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
          ),
        ),
      ),
    );
  }
}
