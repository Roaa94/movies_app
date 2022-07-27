import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({
    Key? key,
    this.width,
    this.height,
    this.minOpacity = 0.05,
    this.maxOpacity = 0.1,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double minOpacity;
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
