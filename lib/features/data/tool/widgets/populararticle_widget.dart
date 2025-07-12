import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import 'likewidget.dart';

class PopularArticleWidget extends StatefulWidget {
  const PopularArticleWidget({
    super.key,
    required this.index,
    required this.image,
    required this.title,
    required this.description,
    required this.ontap,
  });
  final int index;
  final String image;
  final String title;
  final String description;
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
        margin: EdgeInsets.only(right: widget.index == 4 ? 0 : 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AutilabColor.bb),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 8,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: SizedBox(
                height: 171,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return frame != null
                        ? FittedBox(
                            fit: BoxFit.fill,
                            child: child,
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: AutilabColor.bb,
                            ),
                          );
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: AutilabTextStyle.medium16_500,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 2,
                  children: [
                    Expanded(
                      child: Text(
                        widget.description,
                        overflow: TextOverflow.ellipsis,
                        style: AutilabTextStyle.small14_400,
                      ),
                    ),
                    LikeWidget(
                      onTap: () {
                        setState(() {
                          isLike = !isLike;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
