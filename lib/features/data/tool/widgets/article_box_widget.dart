import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:autilab_project/utils/functions/cacheimahe_function.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

// ignore: must_be_immutable
class ArticleBoxWidget extends StatefulWidget {
  ArticleBoxWidget({
    super.key,
    this.isMobile = true,
    required this.image,
    required this.title,
    required this.description,
    required this.ontap,
    this.isLike = false,
  });
  final bool isMobile;
  final String image;
  final String title;
  final String description;
  final Function() ontap;
  bool isLike;

  @override
  State<ArticleBoxWidget> createState() => _ArticleBoxWidgetState();
}

class _ArticleBoxWidgetState extends State<ArticleBoxWidget> {
  bool isLike = false;
  @override
  void initState() {
    super.initState();
    isLike = widget.isLike;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.ontap(),
      child: Container(
        padding: EdgeInsets.all(widget.isMobile ? 12 : 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AutilabColor.bb),
          borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 24),
        ),
        child: SizedBox(
          width: widget.isMobile ? 90 : 145,
          height: widget.isMobile ? 90 : 145,
          child: Row(
            spacing: 12,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: widget.isMobile ? 90 : 145,
                  height: widget.isMobile ? 90 : 145,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                    cacheWidth:
                        cacheImageFunction(widget.isMobile ? 90 : 145, context),
                    cacheHeight:
                        cacheImageFunction(widget.isMobile ? 90 : 145, context),
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
              // SizedBox(
              //   width: widget.isMobile ? 90 : 145,
              //   height: widget.isMobile ? 90 : 145,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(16),
              //     child: Image.asset(
              //       widget.image,
              //       fit: BoxFit.cover,
              //       frameBuilder:
              //           (context, child, frame, wasSynchronouslyLoaded) {
              //         return frame != null
              //             ? FittedBox(
              //                 fit: BoxFit.fill,
              //                 child: child,
              //               )
              //             : const Center(
              //                 child: CircularProgressIndicator(
              //                   color: AutilabColor.bb,
              //                 ),
              //               );
              //       },
              //     ),
              //   ),
              // ),
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
                          style: AutilabTextStyle.medium16_500.copyWith(
                            fontSize: widget.isMobile ? 16 : 24,
                          ),
                        ),
                        Text(
                          widget.description,
                          overflow: TextOverflow.ellipsis,
                          style: AutilabTextStyle.small14_400.copyWith(
                            fontSize: widget.isMobile ? 14 : 20,
                          ),
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
                                width: widget.isMobile ? 16 : 24,
                                height: widget.isMobile ? 16 : 24,
                                cacheWidth: cacheImageFunction(
                                    widget.isMobile ? 16 : 24, context),
                                cacheHeight: cacheImageFunction(
                                    widget.isMobile ? 16 : 24, context),
                              ),
                            ),
                            Text(
                              'Dr.Masoomi',
                              style: AutilabTextStyle.small12_400.copyWith(
                                fontSize: widget.isMobile ? 12 : 16,
                              ),
                            ),
                          ],
                        ),
                        LikeWidget(
                          isMobile: widget.isMobile,
                          isLike: widget.isLike,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
