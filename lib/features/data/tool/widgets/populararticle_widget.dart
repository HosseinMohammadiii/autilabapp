import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class PopularArticleWidget extends StatefulWidget {
  const PopularArticleWidget({
    super.key,
    required this.index,
    required this.ontap,
  });
  final int index;
  final Function() ontap;

  @override
  State<PopularArticleWidget> createState() => _PopularArticleWidgetState();
}

bool isLike = false;

class _PopularArticleWidgetState extends State<PopularArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.only(right: widget.index == 2 ? 0 : 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AutilabColor.white,
          border: Border.all(color: AutilabColor.bb),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 8,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Image.asset(
                'assets/images/kid_image.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Gaming And Autism',
                  style: AutilabTextStyle.medium16_500,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Balancing Screen Time For Kids',
                        style: AutilabTextStyle.small14_400,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLike = !isLike;
                          });
                        },
                        child: isLike
                            ? const Icon(
                                Icons.favorite_rounded,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border_rounded,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
