import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/plan_box_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/home/widgets/new_appointment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../doctor/widgets/specialty_list_widget.dart';
import '../widgets/talent_result_widget.dart';

class StatusClass {
  Color statusColor;
  String statusIcon;
  String title;
  //StatusClass constructor
  StatusClass(this.statusColor, this.statusIcon, this.title);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StatusClass> statusList = [
    StatusClass(
      const Color(0xffFF6363),
      'assets/icons/close_icon.svg',
      'Cancelled',
    ),
    StatusClass(
      const Color(0xff50DD81),
      'assets/icons/done_icon.svg',
      'Approved',
    ),
    StatusClass(
      AutilabColor.gray,
      'assets/icons/minimize_icon.svg',
      'Pending',
    ),
  ];
  List<String> titlePlanList = ['Free Plan', "299\$/Years", '99\$/Month'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'New Appointments',
                      style: AutilabTextStyle.small20_400,
                    ),
                    GestureDetector(
                      child: Text(
                        'See All',
                        style: AutilabTextStyle.medium14_500.copyWith(
                          color: AutilabColor.blue,
                        ),
                      ),
                      onTap: () {
                        context.pushNamed(AutiLabRoutes.allAppointmentScreen);
                      },
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
            SliverToBoxAdapter(
              child: SizedBox(
                height: 290,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3,
                  padding: AutilabMargin.marginFullScreen,
                  itemBuilder: (context, index) {
                    return NewAppointmentsCardWidget(
                      color: statusList[index].statusColor,
                      title: statusList[index].title,
                      statusIcon: statusList[index].statusIcon,
                      image: 'assets/images/doctor_image.png',
                      margin: EdgeInsets.only(
                          right: index == statusList.length - 1 ? 0 : 16),
                      onTap: () {
                        context.pushNamed(
                          AutiLabRoutes.detailAppointmentScreen,
                          extra: {
                            'status': statusList[index],
                          },
                        );
                      },
                    );
                  },
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
                  'Recent Visited',
                  style: AutilabTextStyle.small20_400,
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
                child: SpecialtiesListWidget(),
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
                  'Test Result',
                  style: AutilabTextStyle.small20_400,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 231,
                margin: AutilabMargin.marginFullScreen,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffECF0FF),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AutilabColor.black.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  spacing: 24,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 187,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AutiLab test',
                                style: AutilabTextStyle.medium20_500.copyWith(
                                  color: AutilabColor.blue,
                                ),
                              ),
                              const Text(
                                'Discover Deeper Insights Into Your Unique Personality With Our Autism-Focused Assessment',
                                style: AutilabTextStyle.small14_400,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Image.asset('assets/images/autilab_test_image.png'),
                      ],
                    ),
                    CustomButtonWidget(
                      onTap: () {},
                      height: 50,
                      margin: const EdgeInsets.all(0),
                      color: AutilabColor.bb,
                      text: 'Take A Test',
                      textStyle: AutilabTextStyle.small18_400,
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
                child: Text(
                  'Talent Result',
                  style: AutilabTextStyle.small20_400,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: AutilabMargin.marginFullScreen,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                decoration: BoxDecoration(
                  color: AutilabColor.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Artistic',
                      style: AutilabTextStyle.small14_400,
                    ),
                    TalentResultLinerWidget(
                      gradient1: Color(0xff5b9fc8),
                      gradient2: Color(0xff5b9fc8),
                      activeLine: 13,
                    ),
                    Text(
                      'Enterprising',
                      style: AutilabTextStyle.small14_400,
                    ),
                    TalentResultLinerWidget(
                      gradient1: Color(0xffFF9364),
                      gradient2: Color(0xffF25F33),
                      activeLine: 16,
                    ),
                    Text(
                      'Investigator',
                      style: AutilabTextStyle.small14_400,
                    ),
                    TalentResultLinerWidget(
                      gradient1: Color(0xffB09FFF),
                      gradient2: Color(0xff8D79F6),
                      activeLine: 8,
                    ),
                    Text(
                      'Social',
                      style: AutilabTextStyle.small14_400,
                    ),
                    TalentResultLinerWidget(
                      gradient1: Color(0xffFE6C6C),
                      gradient2: Color(0xffFE464B),
                      activeLine: 11,
                    ),
                    Text(
                      'Realistic',
                      style: AutilabTextStyle.small14_400,
                    ),
                    TalentResultLinerWidget(
                      gradient1: Color(0xff99FFA3),
                      gradient2: Color(0xff68EE76),
                      activeLine: 5,
                    ),
                    Text(
                      'Conventional',
                      style: AutilabTextStyle.small14_400,
                    ),
                    TalentResultLinerWidget(
                      gradient1: Color(0xffFFD572),
                      gradient2: Color(0xffFEBD38),
                      activeLine: 14,
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
            SliverToBoxAdapter(
              child: SizedBox(
                height: 430,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: AutilabMargin.marginFullScreen,
                  itemCount: titlePlanList.length,
                  itemBuilder: (context, index) => PlanBoxWidget(
                    title: titlePlanList[index],
                    margin: index == titlePlanList.length - 1 ? 0 : 16,
                    onTap: () {},
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
