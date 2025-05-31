import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/features/data/tool/model/whiteboard/drawing_tool.dart';
import 'package:flutter/services.dart';

abstract class Stroke {
  final List<Offset> points;
  final Color color;
  final double size;
  final double opacity;
  final String text;
  final StrokeType strokeType;
  final DateTime createdAt = DateTime.now();
  Stroke({
    required this.points,
    this.color = AutilabColor.black,
    this.size = 5,
    this.opacity = 1,
    this.text = '',
    this.strokeType = StrokeType.normal,
  });

  Stroke copyWith({
    List<Offset>? points,
    Color? color,
    double? size,
    double? opacity,
  });
  bool get isEraser => strokeType == StrokeType.eraser;
  bool get isLine => strokeType == StrokeType.line;
  bool get isNormal => strokeType == StrokeType.normal;
}

class TextItem extends Stroke {
  TextItem({
    required super.points,
    super.color,
    super.size,
    super.opacity,
    super.text,
  }) : super(strokeType: StrokeType.normal);
  @override
  TextItem copyWith({
    List<Offset>? points,
    Color? color,
    double? size,
    double? opacity,
    String? text,
  }) {
    return TextItem(
      points: points ?? this.points,
      color: color ?? this.color,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
      text: text ?? this.text,
    );
  }
}

class NormalStroke extends Stroke {
  NormalStroke({
    required super.points,
    super.color,
    super.size,
    super.opacity,
  }) : super(strokeType: StrokeType.normal);

  @override
  NormalStroke copyWith({
    List<Offset>? points,
    Color? color,
    double? size,
    double? opacity,
  }) {
    return NormalStroke(
      points: points ?? this.points,
      color: color ?? this.color,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
    );
  }
}

class EraserStroke extends Stroke {
  EraserStroke({
    required super.points,
    super.color,
    super.size,
    super.opacity,
  }) : super(strokeType: StrokeType.eraser);

  @override
  EraserStroke copyWith({
    List<Offset>? points,
    Color? color,
    double? size,
    double? opacity,
  }) {
    return EraserStroke(
      points: points ?? this.points,
      color: color ?? this.color,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
    );
  }
}

class LineStroke extends Stroke {
  LineStroke({
    required super.points,
    super.color,
    super.size,
    super.opacity,
  }) : super(strokeType: StrokeType.line);

  @override
  LineStroke copyWith({
    List<Offset>? points,
    Color? color,
    double? size,
    double? opacity,
  }) {
    return LineStroke(
      points: points ?? this.points,
      color: color ?? this.color,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
    );
  }
}

class PolygonStroke extends Stroke {
  final int sides;
  final bool filled;

  PolygonStroke({
    required super.points,
    required this.sides,
    this.filled = false,
    super.color,
    super.size,
    super.opacity,
  }) : super(strokeType: StrokeType.polygon);

  @override
  PolygonStroke copyWith({
    List<Offset>? points,
    int? sides,
    Color? color,
    double? size,
    double? opacity,
    bool? filled,
  }) {
    return PolygonStroke(
      points: points ?? this.points,
      sides: sides ?? this.sides,
      color: color ?? this.color,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
      filled: filled ?? this.filled,
    );
  }
}

class CircleStroke extends Stroke {
  final bool filled;

  CircleStroke({
    required super.points,
    this.filled = false,
    super.color,
    super.size,
    super.opacity,
  }) : super(strokeType: StrokeType.circle);

  @override
  CircleStroke copyWith({
    List<Offset>? points,
    Color? color,
    double? size,
    double? opacity,
    bool? filled,
  }) {
    return CircleStroke(
      points: points ?? this.points,
      color: color ?? this.color,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
      filled: filled ?? this.filled,
    );
  }
}

class SquareStroke extends Stroke {
  final bool filled;

  SquareStroke({
    required super.points,
    this.filled = false,
    super.color,
    super.size,
    super.opacity,
  }) : super(strokeType: StrokeType.square);

  @override
  SquareStroke copyWith({
    List<Offset>? points,
    Color? color,
    double? size,
    double? opacity,
    bool? filled,
  }) {
    return SquareStroke(
      points: points ?? this.points,
      color: color ?? this.color,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
      filled: filled ?? this.filled,
    );
  }
}
