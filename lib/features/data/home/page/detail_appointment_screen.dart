import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/box_detail_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/container_more_detail_widget.dart';
import 'package:autilab_project/features/data/home/widgets/box_shape_widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';
import '../../doctor/widgets/personal_detail_widget.dart';
import '../widgets/doctor_box_detail_appointment_widget.dart';

class DetailAppointmentScreen extends StatefulWidget {
  const DetailAppointmentScreen({
    super.key,
    required this.statusColor,
    required this.statusIcon,
    required this.title,
  });

  final Color? statusColor;
  final String statusIcon;
  final String title;
  @override
  State<DetailAppointmentScreen> createState() =>
      _DetailAppointmentScreenState();
}

class _DetailAppointmentScreenState extends State<DetailAppointmentScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DetailAppointmentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
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
                        color: widget.statusColor ?? const Color(0xff50DD81),
                        statusIcon: widget.statusIcon,
                      ),
                      Text(
                        widget.title,
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
      ),
    );
  }
}
