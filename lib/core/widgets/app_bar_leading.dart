import 'package:flutter/material.dart';
import 'package:movies_app/core/configs/styles/app_colors.dart';

class AppBarLeading extends StatefulWidget {
  const AppBarLeading({Key? key}) : super(key: key);

  @override
  State<AppBarLeading> createState() => _AppBarLeadingState();
}

class _AppBarLeadingState extends State<AppBarLeading>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      animationController.forward();
    });
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
      child: Center(
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
      ),
    );
  }
}
