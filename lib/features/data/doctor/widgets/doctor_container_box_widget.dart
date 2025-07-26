import 'package:autilab_project/features/data/doctor/widgets/button_card.dart';
import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/cacheimahe_function.dart';

// ignore: must_be_immutable
class DoctorBox extends StatefulWidget {
  DoctorBox({
    super.key,
    this.isMobile = true,
    this.isLike,
  });
  final bool isMobile;
  bool? isLike;

  @override
  State<DoctorBox> createState() => _DoctorBoxState();
}

class _DoctorBoxState extends State<DoctorBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: AutilabMargin.marginFullScreen,
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SizedBox(
        height: widget.isMobile ? 116 : 248,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/doctor_image.jpg',
                  width: widget.isMobile ? 116 : 248,
                  height: widget.isMobile ? 116 : 248,
                  cacheWidth:
                      cacheImageFunction(widget.isMobile ? 116 : 248, context),
                  cacheHeight:
                      cacheImageFunction(widget.isMobile ? 116 : 248, context),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dr. Sophia Martinez',
                          style: widget.isMobile
                              ? AutilabTextStyle.medium18_500
                              : AutilabTextStyle.medium18_500
                                  .copyWith(fontSize: 32),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          'Speech Therapy',
                          style: AutilabTextStyle.small16_400
                              .copyWith(fontSize: widget.isMobile ? 16 : 24),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () {
                            context.pushNamed(
                                AutiLabRoutes.doctorInformationScreen,
                                extra: {
                                  'isLike': widget.isLike,
                                });
                          },
                          child: Container(
                            height: widget.isMobile ? 32 : 48,
                            width: widget.isMobile ? 100 : 200,
                            margin: EdgeInsets.zero,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xffEDC757),
                              borderRadius: BorderRadius.circular(
                                  widget.isMobile ? 16 : 24),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Info',
                                textAlign: TextAlign.center,
                                style: AutilabTextStyle.small18_400.copyWith(
                                  fontSize: widget.isMobile ? 18 : 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      ButtonCard(
                        isMobile: widget.isMobile,
                        icon: 'assets/icons/messages.svg',
                        onTap: () {
                          context.pushNamed(
                            AutiLabRoutes.doctorMessageScreen,
                            extra: {
                              'image': 'assets/images/doctor_image.jpg',
                              'name': 'Dr. Sophia Martinez',
                              'expertise': 'Speech Therapy',
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: widget.isMobile ? 32 : 68,
                        height: widget.isMobile ? 32 : 68,
                        child: LikeWidget(
                          isMobile: widget.isMobile,
                          backgroundColor: AutilabColor.bb,
                          isLike: widget.isLike ?? false,
                          onTap: () {
                            setState(() {
                              if (widget.isLike != null) {
                                widget.isLike = !widget.isLike!;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
