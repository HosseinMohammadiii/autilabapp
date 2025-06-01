enum DrawingTool {
  brush,
  text,
  eraser,
  square,
  circle;

  bool get isEraser => this == DrawingTool.eraser;
  bool get isPencil => this == DrawingTool.brush;
  bool get isSquare => this == DrawingTool.square;
  bool get isCircle => this == DrawingTool.circle;
}

enum StrokeType {
  undo,
  redo,
  normal,
  eraser,
  line,
  polygon,
  square,
  circle,
  deleteAll;

  static StrokeType fromString(String value) {
    switch (value) {
      case 'undo':
        return StrokeType.undo;
      case 'redo':
        return StrokeType.redo;
      case 'normal':
        return StrokeType.normal;
      case 'eraser':
        return StrokeType.eraser;
      case 'line':
        return StrokeType.line;
      case 'polygon':
        return StrokeType.polygon;
      case 'square':
        return StrokeType.square;
      case 'circle':
        return StrokeType.circle;
      case 'deleteAll':
        return StrokeType.deleteAll;
      default:
        return StrokeType.normal;
    }
  }

  @override
  String toString() {
    switch (this) {
      case StrokeType.undo:
        return 'undo';
      case StrokeType.redo:
        return 'redo';
      case StrokeType.normal:
        return 'normal';
      case StrokeType.eraser:
        return 'eraser';
      case StrokeType.line:
        return 'line';
      case StrokeType.polygon:
        return 'polygon';
      case StrokeType.square:
        return 'square';
      case StrokeType.circle:
        return 'circle';
      case StrokeType.deleteAll:
        return 'deleteAll';
    }
  }
}
