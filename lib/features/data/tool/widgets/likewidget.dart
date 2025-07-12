import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LikeWidget extends StatefulWidget {
  const LikeWidget({
    super.key,
    required this.onTap,
    this.isLike = false,
    this.backgroundColor,
    this.borderColor,
  });
  final Function(bool isLike) onTap;
  final bool isLike;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  bool isLike = false;
  @override
  void initState() {
    super.initState();
    isLike = widget.isLike;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap(isLike);

          isLike = !isLike;
        });
      },
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
        child: isLike
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
