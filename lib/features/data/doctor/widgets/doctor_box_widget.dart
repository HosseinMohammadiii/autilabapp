import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import 'button_card.dart';

class DoctorBoxWidget extends StatefulWidget {
  const DoctorBoxWidget({super.key});

  @override
  State<DoctorBoxWidget> createState() => _DoctorBoxWidgetState();
}

class _DoctorBoxWidgetState extends State<DoctorBoxWidget> {
  List<String> icon = [
    'assets/icons/global_buttomnavigation.svg',
    'assets/icons/messages.svg',
    'assets/icons/calendar.svg',
    'assets/icons/heart.svg',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Male',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AutilabColor.gray,
                    ),
              ),
              const Text(' | '),
              Text(
                'Female',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AutilabColor.blue,
                    ),
              ),
              const Spacer(),
              CustomButtonWidget(
                onTap: () {
                  context.pushNamed(AutiLabRoutes.doctorInformationScreen);
                },
                height: 32,
                width: 100,
                borderRadius: 12,
                margin: const EdgeInsets.all(0),
                color: const Color(0xffEDC757),
                text: 'Info',
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: AutilabColor.black,
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 103,
            child: Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/doctor_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dr. Sophia Martinez',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Psychotherapy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xffEDC757),
                            ),
                            Text(
                              '5.0',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                          child: ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ButtonCard(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      context.pushNamed(AutiLabRoutes
                                          .doctorSocialMediaScreen);
                                    case 1:
                                      context.pushNamed(
                                          AutiLabRoutes.doctorMessageScreen);
                                    case 2:
                                      context.pushNamed(AutiLabRoutes
                                          .doctorWorkscheduleScreen);
                                    default:
                                  }
                                },
                                icon: icon[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomButtonWidget(
            onTap: () {
              context.pushNamed(AutiLabRoutes.makeAppointmentScreen);
            },
            height: 50,
            margin: const EdgeInsets.only(top: 24),
            color: AutilabColor.bb,
            text: 'Make Appointment',
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
