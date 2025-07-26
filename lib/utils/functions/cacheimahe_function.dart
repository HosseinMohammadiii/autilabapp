import 'package:flutter/material.dart';

// Calculates optimal image size based on device pixel ratio for caching
int cacheImageFunction(int number, BuildContext context) {
  double pixelRatio = MediaQuery.of(context).devicePixelRatio;
  int result = (number * pixelRatio).round();
  return result;
}
