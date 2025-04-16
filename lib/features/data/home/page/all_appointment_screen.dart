import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_tabbar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../widgets/new_appointment_card_widget.dart';

class AllAppointmentScreen extends StatefulWidget {
  const AllAppointmentScreen({super.key});

  @override
  State<AllAppointmentScreen> createState() => _AllAppointmentScreenState();
}

class _AllAppointmentScreenState extends State<AllAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationHelper animationHelper;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
  }

  @override
  void didUpdateWidget(covariant AllAppointmentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          context: context, title: 'All Appointment', isIcon: true),
      body: SafeArea(
        child: CustomTabBarWidget(
          tabLength: 3,
          tabBar: const [
            Text(
              'Approved',
              style: AutilabTextStyle.small16_400,
            ),
            Text(
              'Cancelled',
              style: AutilabTextStyle.small16_400,
            ),
            Text(
              'Pending',
              style: AutilabTextStyle.small16_400,
            ),
          ],
          tabBarView: [
            FadeTransition(
              opacity: animationHelper.fadeAnimation,
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return NewAppointmentsCardWidget(
                        color: const Color(0xff50DD81),
                        title: 'Approved',
                        image: 'assets/images/doctor2.png',
                        statusIcon: 'assets/icons/done_icon.svg',
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        onTap: () {},
                      );
                    },
                  ),
                ],
              ),
            ),
            FadeTransition(
              opacity: animationHelper.fadeAnimation,
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return NewAppointmentsCardWidget(
                        color: const Color(0xffFF6363),
                        title: 'Cancelled',
                        image: 'assets/images/doctor_image.png',
                        statusIcon: 'assets/icons/close_icon.svg',
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        onTap: () {},
                      );
                    },
                  ),
                ],
              ),
            ),
            FadeTransition(
              opacity: animationHelper.fadeAnimation,
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return NewAppointmentsCardWidget(
                        color: AutilabColor.gray,
                        title: 'Pending',
                        image: 'assets/images/doctor3.png',
                        statusIcon: 'assets/icons/minimize_icon.svg',
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        onTap: () {},
                      );
                    },
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
