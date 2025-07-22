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
    this.isMobile = true,
  });
  final bool isMobile;
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
        width: widget.isMobile ? 32 : 68,
        height: widget.isMobile ? 32 : 68,
        padding: EdgeInsets.all(widget.isMobile ? 6 : 15),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AutilabColor.drawerWhite,
          borderRadius: BorderRadius.circular(widget.isMobile ? 12 : 24),
          border: Border.all(
            width: 0.5,
            color: widget.borderColor ?? AutilabColor.bb,
          ),
        ),
        child: widget.isLike
            ? SvgPicture.asset(
                'assets/icons/redheart.svg',
                width: widget.isMobile ? 16 : 21,
                height: widget.isMobile ? 16 : 21,
              )
            : SvgPicture.asset(
                'assets/icons/heart.svg',
                width: widget.isMobile ? 16 : 21,
                height: widget.isMobile ? 16 : 21,
              ),
      ),
    );
  }
}
