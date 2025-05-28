import 'dart:ui';

import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/features/data/tool/model/whiteboard/drawing_tool.dart';

class DrawingcanvasOptionModel {
  final Color strokeColor;
  final double size;
  final double opacity;
  final DrawingTool currentTool;
  const DrawingcanvasOptionModel({
    this.strokeColor = AutilabColor.black,
    this.size = 10,
    this.opacity = 1,
    this.currentTool = DrawingTool.brush,
  });
}
