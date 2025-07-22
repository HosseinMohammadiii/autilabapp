import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatusShapeWidget extends StatelessWidget {
  const StatusShapeWidget({
    super.key,
    this.isMobile = true,
    required this.color,
    required this.statusIcon,
  });
  final bool isMobile;
  final Color color;
  final String statusIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 24 : 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        statusIcon,
        height: isMobile ? 24 : 32,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
