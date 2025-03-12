import 'package:autilab_project/features/data/doctor/widgets/button_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../core/constants/theme_constant.dart';

class DoctorBox extends StatelessWidget {
  const DoctorBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 136,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: AutilabMargin.marginFullScreen,
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/doctor_image.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        'Dr. Sophia Martinez',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        'Psychotherapy',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
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
                          context
                              .pushNamed(AutiLabRoutes.doctorInformationScreen);
                        },
                        height: 32,
                        width: 100,
                        borderRadius: 12,
                        margin: const EdgeInsets.all(0),
                        color: AutilabColor.yellow2,
                        text: 'Info',
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                      ),
                    ),
                    const Spacer(),
                    ButtonCard(
                      icon: 'assets/icons/messages.svg',
                      onTap: () {
                        context.pushNamed(AutiLabRoutes.doctorMessageScreen);
                      },
                    ),
                    ButtonCard(
                      icon: 'assets/icons/heart.svg',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
