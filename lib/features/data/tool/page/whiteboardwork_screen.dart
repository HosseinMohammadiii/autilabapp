import 'dart:io';

import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/tool/model/whiteboard/drawing_tool.dart';
import 'package:autilab_project/features/data/tool/model/whiteboard/notifieres/current_stroke_value_notifier.dart';
import 'package:autilab_project/features/data/tool/model/whiteboard/sketch.dart';
import 'package:flutter/material.dart';

final key = GlobalKey();

// ignore: must_be_immutable
class WhiteboardWorkScreen extends StatefulWidget {
  WhiteboardWorkScreen({
    super.key,
    required this.selectedColor,
    required this.strokeType,
    required this.onChanged,
    required this.isUpload,
    required this.image,
  });
  final ValueNotifier<Color> selectedColor;

  final ValueNotifier<StrokeType> strokeType;

  final bool isUpload;
  File? image;

  final Function() onChanged;

  @override
  State<WhiteboardWorkScreen> createState() => _WhiteboardWorkScreenState();
}

class _WhiteboardWorkScreenState extends State<WhiteboardWorkScreen> {
  // Key for accessing RepaintBoundary

  final CurrentStrokeValueNotifier currentStroke = CurrentStrokeValueNotifier();
  final ValueNotifier<List<Stroke>> allStrokes = ValueNotifier([]);
  final ValueNotifier<List<Stroke>> restoreStrokes = ValueNotifier([]);
  final ValueNotifier<List<Stroke>> texts = ValueNotifier([]);

// Position and controller for adding text input
  Offset? textInputPosition;
  TextEditingController textController = TextEditingController();

  @override
  void didUpdateWidget(covariant WhiteboardWorkScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle deleteAll: clear all strokes and reset state
    if (widget.strokeType.value == StrokeType.deleteAll) {
      allStrokes.value.clear();
      restoreStrokes.value.clear();
      currentStroke.value = null;
      // widget.image = null;
      // Handle undo: move last stroke to restore list
    } else if (widget.strokeType.value == StrokeType.undo) {
      _handleUndo();

      // Handle redo: move last restored stroke back to strokes list
    } else if (widget.strokeType.value == StrokeType.redo) {
      _handleRedo();
    }
  }

// Remove last stroke and store it in restore list for redo
  void _handleUndo() {
    if (allStrokes.value.isNotEmpty) {
      final lastStroke = allStrokes.value.removeLast();
      restoreStrokes.value = List.from(restoreStrokes.value)..add(lastStroke);
      currentStroke.value = null;
    }
  }

// Restore last undone stroke back to strokes list
  void _handleRedo() {
    if (restoreStrokes.value.isNotEmpty) {
      final lastRestore = restoreStrokes.value.removeLast();
      allStrokes.value = List.from(allStrokes.value)..add(lastRestore);
    }
  }

  void _showTextInputDialog(BuildContext context, List<Offset> position) {
    // Clear the text field before showing the dialog
    textController.clear();

    // Show an alert dialog with a TextField for entering text
    showDialog(
      context: context,
      builder: (context) {
        return FittedBox(
          child: AlertDialog(
            title: const Text(
              "Enter Text",
              style: AutilabTextStyle.small20_400,
            ),
            content: TextField(
              controller: textController,
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // If text is not empty, create a TextItem and add it to the strokes list
                  if (textController.text.isNotEmpty) {
                    allStrokes.value = List.from(allStrokes.value)
                      ..add(
                        TextItem(
                          points: position,
                          text: textController.text,
                          color: widget.selectedColor.value,
                        ),
                      );
                  }

                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Add',
                  style: AutilabTextStyle.small18_400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: key,
      child: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF5F0CD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                widget.isUpload
                    ? 'assets/images/upload_image_background.png'
                    : 'assets/images/whiteboardBackground.png',
                fit: BoxFit.fill,
                opacity: const AlwaysStoppedAnimation(.3),
              ),
            ),
          ),
          widget.image?.path != null && widget.isUpload
              ? Center(
                  child: Image.file(
                    widget.image!,
                  ),
                )
              : const SizedBox(),
          buildAllStroke(),
          buildCurrentPath(context),
        ],
      ),
    );
  }

// Paint all completed strokes and text items
  Widget buildAllStroke() {
    return SizedBox.expand(
      child: ValueListenableBuilder(
        valueListenable: allStrokes,
        builder: (context, value, child) {
          return ClipRect(
            child: CustomPaint(
              painter: SketchPainter(
                strokers: allStrokes.value,
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
        child: GestureDetector(
          onTapDown: (event) {
            final box = context.findRenderObject() as RenderBox;
            final offset = box.globalToLocal(event.globalPosition);

            final points = List<Offset>.from(currentStroke.value?.points ?? [])
              ..add(offset);
            //If strokeType is text display _showTextInputDialog method
            if (widget.strokeType.value == StrokeType.text) {
              _showTextInputDialog(context, points);
            }
            return;
          },
          onPanDown: (event) {
            final box = context.findRenderObject() as RenderBox;
            final offset = box.globalToLocal(event.globalPosition);

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
          onPanUpdate: (event) async {
            final box = context.findRenderObject() as RenderBox;
            final offset = box.globalToLocal(event.globalPosition);

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
          onPanEnd: (event) {
            if (currentStroke.value != null) {
              allStrokes.value = List<Stroke>.from(allStrokes.value)
                ..add(currentStroke.value!);

              // Clear redo history when new stroke added
              restoreStrokes.value = [];
              currentStroke.value = null;
            }
          },
          child: ValueListenableBuilder(
            valueListenable: currentStroke,
            builder: (context, value, child) {
              return ClipRRect(
                child: CustomPaint(
                  painter: SketchPainter(
                    strokers: currentStroke.value == null
                        ? []
                        : [currentStroke.value!],
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

  SketchPainter({required this.strokers});

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
        case StrokeType.text:
          inputText(canvas);
          break;

        default:
          canvas.drawPath(path, paint);
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

//Method inputText for
  void inputText(Canvas canvas) {
    // Loop through each text item in the list of strokes
    for (final textItem in strokers) {
      // Create a TextSpan with the text content, color, and font size
      final textSpan = TextSpan(
        text: textItem.text,
        style: TextStyle(
          color: textItem.color,
          fontSize: 18.0,
        ),
      );

      // Create a TextPainter to layout and paint the text
      final tp = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      tp.layout();

      // Paint the text at the specified position
      tp.paint(canvas, textItem.points.first);
    }
  }
}
