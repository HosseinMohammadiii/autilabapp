import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import 'likewidget.dart';

// ignore: must_be_immutable
class PopularArticleWidget extends StatefulWidget {
  PopularArticleWidget({
    super.key,
    this.isMobile = true,
    required this.index,
    required this.image,
    required this.title,
    required this.description,
    required this.ontap,
    this.isLike = false,
  });
  final bool isMobile;
  final int index;
  final String image;
  final String title;
  final String description;
  bool? isLike;
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
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: widget.isMobile ? 171 : 234,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                  cacheWidth: 300,
                  cacheHeight: 200,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (frame == null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AutilabColor.bb,
                        ),
                      );
                    } else {
                      return child;
                    }
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
                  style: AutilabTextStyle.medium16_500.copyWith(
                    fontSize: widget.isMobile ? 16 : 24,
                  ),
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
                        style: AutilabTextStyle.small14_400.copyWith(
                          fontSize: widget.isMobile ? 14 : 20,
                        ),
                      ),
                    ),
                    LikeWidget(
                      isMobile: widget.isMobile,
                      isLike: isLike,
                      onTap: () {
                        setState(() {
                          isLike = !isLike;
                          widget.isLike = isLike;
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
