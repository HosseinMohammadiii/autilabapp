import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/box_detail_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/container_more_detail_widget.dart';
import 'package:autilab_project/features/data/home/widgets/box_shape_widget.dart';
import 'package:flutter/material.dart';

import '../../doctor/widgets/personal_detail_widget.dart';
import '../widgets/doctor_box_detail_appointment_widget.dart';
import 'home_screen.dart';

class DetailAppointmentScreen extends StatefulWidget {
  const DetailAppointmentScreen({
    super.key,
    required this.status,
  });
  final StatusClass status;
  @override
  State<DetailAppointmentScreen> createState() =>
      _DetailAppointmentScreenState();
}

class _DetailAppointmentScreenState extends State<DetailAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          context: context, title: 'Detail Appointment', isIcon: true),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 22,
              ),
            ),
            const SliverToBoxAdapter(
              child: DoctorBoxDetialAppointmentWidget(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 32,
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                'Your Appointment Has Been Canceled',
                style: AutilabTextStyle.small16_400,
                textAlign: TextAlign.center,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'By The Doctor',
                style: AutilabTextStyle.small16_400.copyWith(
                  color: AutilabColor.bb,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 50,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFBE4E4),
                  border: Border.all(
                    color: const Color(0xffFF6363),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatusShapeWidget(
                      color: widget.status.statusColor,
                      statusIcon: widget.status.statusIcon,
                    ),
                    Text(
                      widget.status.title,
                      style: AutilabTextStyle.small16_400,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
              ),
            ),
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: Divider(
                  thickness: 1,
                  color: AutilabColor.gray,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: PersonalDetailWidget(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: Column(
                  spacing: 12,
                  children: [
                    BoxDetailWidget(
                        title: 'Full Name', subtitle: 'Alexei Oppana'),
                    BoxDetailWidget(title: 'Age', subtitle: '8'),
                    BoxDetailWidget(title: 'Gender', subtitle: 'Female'),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: Divider(
                  thickness: 1,
                  color: AutilabColor.gray,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
              ),
            ),
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Problem',
                  style: AutilabTextStyle.medium18_500,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: ContainerDetailBox(
                  detail:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequatenim ad minim veniam, quis nostrud exercitation ullamco laboris',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
