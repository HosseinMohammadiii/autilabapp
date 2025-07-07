import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class ArticleBoxWidget extends StatefulWidget {
  const ArticleBoxWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.ontap,
  });
  final String image;
  final String title;
  final String description;
  final Function() ontap;

  @override
  State<ArticleBoxWidget> createState() => _ArticleBoxWidgetState();
}

class _ArticleBoxWidgetState extends State<ArticleBoxWidget> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.ontap(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AutilabColor.bb),
          borderRadius: BorderRadius.circular(24),
        ),
        child: SizedBox(
          height: 90,
          child: Row(
            spacing: 12,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10,
                  children: [
                    Column(
                      spacing: 2,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          style: AutilabTextStyle.medium16_500,
                        ),
                        Text(
                          widget.description,
                          overflow: TextOverflow.ellipsis,
                          style: AutilabTextStyle.small14_400,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 4,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(85),
                              child: Image.asset(
                                'assets/images/doctor4.png',
                                width: 16,
                                height: 16,
                              ),
                            ),
                            const Text(
                              'Dr.Masoomi',
                              style: AutilabTextStyle.small12_400,
                            ),
                          ],
                        ),
                        LikeWidget(
                          onTap: (isLike) {
                            setState(() {
                              isLike = !isLike;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
