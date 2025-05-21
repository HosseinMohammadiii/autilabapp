import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constant_routes.dart';
import '../../home/widgets/new_appointment_card_widget.dart';

class ExpiredAppointmentWidget extends StatelessWidget {
  const ExpiredAppointmentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return NewAppointmentsCardWidget(
              color: const Color(0xff50DD81),
              title: 'Approved',
              statusIcon: 'assets/icons/done_icon.svg',
              image: 'assets/images/doctor_image.png',
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 16),
              onTap: () {
                context.pushNamed(
                  AutiLabRoutes.detailAppointmentScreen,
                  extra: {
                    'statusColor': const Color(0xff50DD81),
                    'statusIcon': 'assets/icons/done_icon.svg',
                    'title': 'Approved',
                  },
                );
              },
            );
          },
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ),
      ],
    );
  }
}
