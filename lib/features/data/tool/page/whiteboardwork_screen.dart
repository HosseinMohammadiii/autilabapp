import 'package:autilab_project/features/data/tool/model/whiteboard/notifieres/current_stroke_value_notifier.dart';
import 'package:autilab_project/features/data/tool/model/whiteboard/sketch.dart';
import 'package:flutter/material.dart';

class WhiteboardWorkScreen extends StatefulWidget {
  const WhiteboardWorkScreen({
    super.key,
    required this.selectedColor,
  });
  final ValueNotifier<Color> selectedColor;

  @override
  State<WhiteboardWorkScreen> createState() => _WhiteboardWorkScreenState();
}

class _WhiteboardWorkScreenState extends State<WhiteboardWorkScreen> {
  final ValueNotifier<double> strokeSize = ValueNotifier(10.0);
  final ValueNotifier<double> eraserSize = ValueNotifier(30.0);
  final CurrentStrokeValueNotifier currentStroke = CurrentStrokeValueNotifier();
  final ValueNotifier<List<Stroke>> allStrokes = ValueNotifier([]);

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

  Widget buildAllStroke() {
    return SizedBox.expand(
      child: ValueListenableBuilder(
        valueListenable: allStrokes,
        builder: (context, value, child) {
          return ClipRect(
            child: RepaintBoundary(
              child: CustomPaint(
                painter: SketchPainter(strokers: allStrokes.value),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    return MouseRegion(
      child: SizedBox.expand(
        child: Listener(
          onPointerDown: (event) {
            final box = context.findRenderObject() as RenderBox;
            final offset = box.globalToLocal(event.position);

            currentStroke.value = LineStroke(
              points: [offset],
              color: widget.selectedColor.value,
            );
          },
          onPointerMove: (event) {
            final box = context.findRenderObject() as RenderBox;
            final offset = box.globalToLocal(event.position);
            final points = List<Offset>.from(currentStroke.value?.points ?? [])
              ..add(offset);

            currentStroke.value = LineStroke(
              points: points,
              color: widget.selectedColor.value,
            );
          },
          onPointerUp: (event) {
            allStrokes.value = List<Stroke>.from(allStrokes.value)
              ..add(currentStroke.value!);
          },
          child: ValueListenableBuilder(
            valueListenable: currentStroke,
            builder: (context, value, child) {
              return ClipRect(
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: SketchPainter(
                        strokers: currentStroke.value == null
                            ? []
                            : [currentStroke.value!]),
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
  final ValueNotifier<double> strokeSize = ValueNotifier(5.0);

  SketchPainter({required this.strokers});

  @override
  void paint(Canvas canvas, Size size) {
    for (Stroke stroke in strokers) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = strokeSize.value
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      final points = stroke.points;
      if (points.length < 2) continue;

      final path = Path();
      path.moveTo(points.first.dx, points.first.dy);

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

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
