import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';

/// Slider action widget like next, prev, download
class SliderAction extends StatelessWidget {
  /// Creates a new instance of [SliderAction]
  const SliderAction({
    Key? key,
    required this.icon,
    this.onTap,
    this.color = AppColors.primary,
  }) : super(key: key);

  /// Icons widget inside the slider action
  final Widget icon;

  /// onTap action
  final VoidCallback? onTap;

  /// widget background color
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
              padding: const EdgeInsets.all(8),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
