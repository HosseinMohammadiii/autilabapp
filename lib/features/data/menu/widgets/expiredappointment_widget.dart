import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constant_routes.dart';
import '../../home/widgets/new_appointment_card_widget.dart';

class ExpiredAppointmentWidget extends StatelessWidget {
  const ExpiredAppointmentWidget({
    super.key,
    this.isMobile = true,
  });
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return SizedBox(
              height: isMobile ? 252 : 409,
              child: NewAppointmentsCardWidget(
                isMobile: isMobile,
                color: const Color(0xff50DD81),
                backgroundColor: AutilabColor.lightGray,
                title: 'Approved',
                isShowRate: true,
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
                    },
                  );
                },
              ),
            );
          },
        ),
        // Positioned.fill(
        //   child: IgnorePointer(
        //     child: Container(
        //       color: Colors.white.withValues(alpha: 0.3),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
