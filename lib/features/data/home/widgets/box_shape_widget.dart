import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatusShapeWidget extends StatelessWidget {
  const StatusShapeWidget({
    super.key,
    required this.color,
    required this.statusIcon,
  });

  final Color color;
  final String statusIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        statusIcon,
        height: 24,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
