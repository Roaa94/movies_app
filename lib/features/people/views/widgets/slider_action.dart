import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';

class SliderAction extends StatelessWidget {
  const SliderAction({
    Key? key,
    required this.icon,
    this.onTap,
    this.color = AppColors.primary,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
