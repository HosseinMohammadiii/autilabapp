import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LikeWidget extends StatefulWidget {
  const LikeWidget({
    super.key,
    required this.onTap,
    this.isLike = true,
    this.backgroundColor,
    this.borderColor,
  });
  final Function() onTap;
  final bool isLike;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AutilabColor.drawerWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 0.5,
            color: widget.borderColor ?? AutilabColor.bb,
          ),
        ),
        child: widget.isLike
            ? SvgPicture.asset(
                'assets/icons/redheart.svg',
                width: 16,
                height: 16,
              )
            : SvgPicture.asset(
                'assets/icons/heart.svg',
                width: 16,
                height: 16,
              ),
      ),
    );
  }
}
