import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LikeWidget extends StatelessWidget {
  const LikeWidget({
    super.key,
    required this.onTap,
    required this.isLike,
  });
  final Function() onTap;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
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
