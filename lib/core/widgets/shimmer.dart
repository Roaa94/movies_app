import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';

/// Shimmer widget with simple fade animation
class Shimmer extends StatefulWidget {
  /// Creates a new instance of [Shimmer]
  const Shimmer({
    Key? key,
    this.width,
    this.height,
    this.minOpacity = 0.05,
    this.maxOpacity = 0.1,
  }) : super(key: key);

  /// Shimmer area width
  final double? width;

  /// Shimmer area height
  final double? height;

  /// Shimmer fade minimum opacity
  final double minOpacity;

  /// Shimmer fade maximum opacity
  final double maxOpacity;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: widget.minOpacity,
      upperBound: widget.maxOpacity,
    );
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
