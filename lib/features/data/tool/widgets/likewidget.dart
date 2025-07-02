import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LikeWidget extends StatefulWidget {
  const LikeWidget({
    super.key,
    required this.onTap,
  });
  final Function(bool isLike) onTap;

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap(isLike);

          isLike = !isLike;
        });
      },
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
    );
  }
}
