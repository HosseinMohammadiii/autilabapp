import 'package:flutter/material.dart';

class AnimationHelper {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  final double? begin;

  AnimationHelper(
      {required TickerProvider vsync, Duration? duration, this.begin}) {
    //Animation duration define
    animationController = AnimationController(
      vsync: vsync,
      duration: duration ?? const Duration(seconds: 1),
    );
    //Define animate animation
    fadeAnimation = Tween<double>(begin: begin ?? 0.0, end: 1.0)
        .animate(animationController);
  }
  void restartAnimation() {
    animationController.forward(from: 0);
  }

  void dispose() {
    animationController.dispose();
  }
}
