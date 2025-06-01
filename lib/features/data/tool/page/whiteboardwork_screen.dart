import 'package:autilab_project/features/data/tool/model/whiteboard/drawing_tool.dart';
import 'package:autilab_project/features/data/tool/model/whiteboard/notifieres/current_stroke_value_notifier.dart';
import 'package:autilab_project/features/data/tool/model/whiteboard/sketch.dart';
import 'package:flutter/material.dart';

class WhiteboardWorkScreen extends StatefulWidget {
  const WhiteboardWorkScreen({
    super.key,
    required this.selectedColor,
    required this.strokeType,
    // required this.isLine,
  });
  final ValueNotifier<Color> selectedColor;

  final ValueNotifier<StrokeType> strokeType;
  // final ValueNotifier<bool> isLine;

  @override
  State<WhiteboardWorkScreen> createState() => _WhiteboardWorkScreenState();
}

class _WhiteboardWorkScreenState extends State<WhiteboardWorkScreen> {
  final CurrentStrokeValueNotifier currentStroke = CurrentStrokeValueNotifier();
  final ValueNotifier<List<Stroke>> allStrokes = ValueNotifier([]);
  final ValueNotifier<List<TextItem>> texts = ValueNotifier([]);

// Position and controller for adding text input
  Offset? textInputPosition;
  TextEditingController textController = TextEditingController();

  @override
  void didUpdateWidget(covariant WhiteboardWorkScreen oldWidget) {
    if (widget.strokeType.value == StrokeType.deleteAll) {
      setState(() {
        allStrokes.value.clear();
        currentStroke.value = null;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffF5F0CD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/images/whiteboardBackground.png',
              fit: BoxFit.fill,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
        ),
        buildAllStroke(),
        buildCurrentPath(context),
      ],
    );
  }

// Paint all completed strokes and text items
  Widget buildAllStroke() {
    return SizedBox.expand(
      child: ValueListenableBuilder(
        valueListenable: allStrokes,
        builder: (context, value, child) {
          return ClipRect(
            child: RepaintBoundary(
              child: CustomPaint(
                painter: SketchPainter(
                  strokers: allStrokes.value,
                  texts: texts.value,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// Handle user interaction for drawing on the canvas
  Widget buildCurrentPath(BuildContext context) {
    return MouseRegion(
      child: SizedBox.expand(
        child: Listener(
          onPointerDown: (event) {
            final box = context.findRenderObject() as RenderBox;
            final offset = box.globalToLocal(event.position);

            // Initialize stroke when user starts drawing
            switch (widget.strokeType.value) {
              case StrokeType.normal:
                currentStroke.value = NormalStroke(
                  points: [offset],
                  color: widget.selectedColor.value,
                );
                break;
              case StrokeType.eraser:
                currentStroke.value = EraserStroke(
                  points: [offset],
                );
                break;

              default:
                currentStroke.value = NormalStroke(
                  points: [offset],
                  color: widget.selectedColor.value,
                );
            }
          },
          onPointerMove: (event) {
            final box = context.findRenderObject() as RenderBox;
            final offset = box.globalToLocal(event.position);

            // Add new point to current stroke
            final points = List<Offset>.from(currentStroke.value?.points ?? [])
              ..add(offset);

            // Update current stroke with accumulated points
            switch (widget.strokeType.value) {
              case StrokeType.normal:
                currentStroke.value = NormalStroke(
                  points: points,
                  color: widget.selectedColor.value,
                );
                break;
              case StrokeType.eraser:
                currentStroke.value = EraserStroke(
                  points: points,
                );
                break;
              case StrokeType.circle:
                currentStroke.value = CircleStroke(
                  points: points,
                  color: widget.selectedColor.value,
                );
                break;
              case StrokeType.polygon:
                currentStroke.value = PolygonStroke(
                  sides: 4,
                  points: points,
                  color: widget.selectedColor.value,
                );
                break;
              default:
                currentStroke.value = NormalStroke(
                  points: points,
                  color: widget.selectedColor.value,
                );
            }
          },
          onPointerUp: (event) {
            // Save finished stroke to list and reset current stroke
            allStrokes.value = List<Stroke>.from(allStrokes.value)
              ..add(currentStroke.value!);
          },
          child: ValueListenableBuilder(
            valueListenable: currentStroke,
            builder: (context, value, child) {
              return ClipRRect(
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: SketchPainter(
                      strokers: currentStroke.value == null
                          ? []
                          : [currentStroke.value!],
                      texts: texts.value,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Stroke> strokers;
  final List<TextItem> texts;
  SketchPainter({required this.strokers, required this.texts});

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    canvas.saveLayer(bounds, Paint());

    for (Stroke stroke in strokers) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = 5.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Configure paint for eraser or drawing
      if (stroke.isEraser) {
        paint.blendMode = BlendMode.clear;
      } else {
        paint.color = stroke.color;
      }
      final points = stroke.points;
      if (points.length < 2) continue;

      final path = Path();
      path.moveTo(points.first.dx, points.first.dy);

      // Smooth curve using quadratic Bezier
      for (var i = 1; i < points.length - 1; ++i) {
        final p0 = points[i];
        final p1 = points[i + 1];
        path.quadraticBezierTo(
          p0.dx,
          p0.dy,
          (p0.dx + p1.dx) / 2,
          (p0.dy + p1.dy) / 2,
        );
      }
      Offset firstPoint = stroke.points.first;
      Offset lastPoint = stroke.points.last;
      Rect rect = Rect.fromPoints(firstPoint, lastPoint);

      // Draw different shapes based on stroke type
      switch (stroke.strokeType) {
        case StrokeType.normal:
          canvas.drawPath(path, paint);
          break;
        case StrokeType.line:
          canvas.drawLine(firstPoint, lastPoint, paint);
          break;
        case StrokeType.circle:
          canvas.drawOval(rect, paint);
          break;
        case StrokeType.polygon:
          canvas.drawRect(rect, paint);
          break;

        default:
          canvas.drawPath(path, paint);
      }
    }
    canvas.restore();
    // for (final textItem in texts) {
    //   final textSpan = TextSpan(
    //     text: textItem.text,
    //     style: TextStyle(
    //       color: textItem.color,
    //     ),
    //   );
    //   final tp = TextPainter(
    //     text: textSpan,
    //     textDirection: TextDirection.ltr,
    //   );
    //   tp.layout();
    //   tp.paint(canvas, textItem.points.first);

    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
