import 'package:flutter/material.dart';

Future<void> animationMethode(
  AnimationController animation,
  Animation<double> fadeInFadeOut,
  TickerProviderStateMixin ticker,
) async {
  //Animation duration define
  animation = AnimationController(
    vsync: ticker,
    duration: const Duration(seconds: 4),
  );
  //Define animate animation
  fadeInFadeOut = Tween<double>(begin: 0.3, end: 1).animate(animation);

  animation.forward();
}
