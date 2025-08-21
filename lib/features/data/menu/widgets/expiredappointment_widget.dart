import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constant_routes.dart';
import '../../home/data/model/newappointment_model.dart';
import '../../home/widgets/new_appointment_card_widget.dart';

class ExpiredAppointmentWidget extends StatelessWidget {
  const ExpiredAppointmentWidget({
    super.key,
    this.isMobile = true,
    this.newappointmentModel,
    required this.color,
    required this.title,
    required this.statusIcon,
  });
  final bool isMobile;
  final List<NewappointmentModel>? newappointmentModel;

  final Color color;
  final String title;
  final String statusIcon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return SizedBox(
              height: isMobile ? 256 : 409,
              child: NewAppointmentsCardWidget(
                isMobile: isMobile,
                color: const Color(0xff50DD81),
                backgroundColor: AutilabColor.lightGray,
                title: 'Caceled',
                isShowRate: true,
                statusIcon: 'assets/icons/done_icon.svg',
                image:
                    newappointmentModel?[index].doctorModel.doctorUser.photo ??
                        'assets/images/doctor_image.jpg',
                margin: const EdgeInsets.only(right: 20, left: 20, bottom: 16),
                raiteOnTap: () {},
                onTap: () {
                  context.pushNamed(
                    AutiLabRoutes.detailAppointmentScreen,
                    extra: {
                      'newappointmentModel':
                          newappointmentModel?[index].description,
                      'statusColor': const Color(0xff50DD81),
                      'statusIcon': 'assets/icons/done_icon.svg',
                      'title': 'Approved',
                      'image': 'assets/images/doctor_image.jpg',
                      'descriptionStatus': 'Your Appointment Has Been Approved',
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
