import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constant_routes.dart';
import '../../home/widgets/new_appointment_card_widget.dart';

class ValidAppointmentWidget extends StatelessWidget {
  const ValidAppointmentWidget({
    super.key,
    this.isMobile = true,
  });
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SizedBox(
          height: isMobile ? 252 : 409,
          child: NewAppointmentsCardWidget(
            isMobile: isMobile,
            color: const Color(0xff50DD81),
            title: 'Approved',
            statusIcon: 'assets/icons/done_icon.svg',
            image: 'assets/images/doctor_image.jpg',
            margin: const EdgeInsets.only(right: 20, left: 20, bottom: 16),
            raiteOnTap: () {},
            onTap: () {
              context.pushNamed(
                AutiLabRoutes.detailAppointmentScreen,
                extra: {
                  'statusColor': const Color(0xff50DD81),
                  'statusIcon': 'assets/icons/done_icon.svg',
                  'title': 'Approved',
                  'image': 'assets/images/doctor_image.jpg',
                  'descriptionStatus': 'Your Appointment Is Being Reviewed',
                },
              );
            },
          ),
        );
      },
    );
  }
}
