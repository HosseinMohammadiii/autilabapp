import 'package:autilab_project/features/data/doctor/widgets/button_card.dart';
import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../core/constants/theme_constant.dart';

// ignore: must_be_immutable
class DoctorBox extends StatefulWidget {
  DoctorBox({
    super.key,
    this.isLike,
  });
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
        height: 116,
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
                  width: 116,
                  height: 116,
                  fit: BoxFit.fill,
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          'Dr. Sophia Martinez',
                          style: AutilabTextStyle.medium18_500,
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          'Speech Therapy',
                          style: AutilabTextStyle.small16_400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: CustomButtonWidget(
                          onTap: () {
                            context.pushNamed(
                              AutiLabRoutes.doctorInformationScreen,
                              extra: {
                                'isLike': widget.isLike,
                              },
                            );
                          },
                          height: 32,
                          width: 100,
                          borderRadius: 12,
                          margin: const EdgeInsets.all(0),
                          color: AutilabColor.yellow2,
                          text: 'Info',
                          textStyle: AutilabTextStyle.small14_400,
                        ),
                      ),
                      const Spacer(),
                      ButtonCard(
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
                        width: 32,
                        height: 32,
                        child: LikeWidget(
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
