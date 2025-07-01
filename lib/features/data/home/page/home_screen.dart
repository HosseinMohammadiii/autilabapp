import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/plan_box_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/home/widgets/new_appointment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/test_result_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../doctor/widgets/specialty_list_widget.dart';
import '../widgets/plan_item_widget.dart';

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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

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
  List<String> titlePlanList = ['Free Plan', '99\$/Month', "299\$/Years"];
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
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
                  height: 24,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: SizedBox(
                    height: 290,
                    child: PageView.builder(
                      itemCount: 3,
                      padEnds: false,
                      pageSnapping: false,
                      controller: PageController(viewportFraction: 0.9),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 20 : 12,
                            right: index == statusList.length - 1 ? 8 : 0,
                          ),
                          child: NewAppointmentsCardWidget(
                            color: statusList[index].statusColor,
                            title: statusList[index].title,
                            statusIcon: statusList[index].statusIcon,
                            image: 'assets/images/doctor_image.jpg',
                            margin: EdgeInsets.zero,
                            onTap: () {
                              context.pushNamed(
                                AutiLabRoutes.detailAppointmentScreen,
                                extra: {
                                  'statusColor': statusList[index].statusColor,
                                  'statusIcon': statusList[index].statusIcon,
                                  'image': 'assets/images/doctor_image.jpg',
                                  'title': statusList[index].title,
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
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
              const SliverToBoxAdapter(
                child: SpecialtiesListWidget(
                  height: 113,
                  width: 112,
                  textStyle: AutilabTextStyle.small14_400,
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
                    spacing: 26,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    'AutiLab Test',
                                    style:
                                        AutilabTextStyle.medium20_500.copyWith(
                                      color: AutilabColor.blue,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Discover Deeper Insights Into Your Unique Personality With Our Autism-Focused Assessment',
                                  style: AutilabTextStyle.small14_400,
                                ),
                              ],
                            ),
                          ),
                          Image.asset('assets/images/autilab_test_image.png'),
                        ],
                      ),
                      CustomButtonWidget(
                        onTap: () {
                          context.pushNamed(AutiLabRoutes.typeTestsScreen);
                        },
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
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: TestResultWidget(
                    isShowTitle: false,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 430,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      padEnds: false,
                      pageSnapping: false,
                      controller: PageController(viewportFraction: 0.9),
                      itemCount: titlePlanList.length,
                      itemBuilder: (context, index) => PlanBoxWidget(
                        title: titlePlanList[index],
                        titleButton: 'See Advance Package',
                        widget: const Column(
                          spacing: 8,
                          children: [
                            PalnItemWidget(),
                            PalnItemWidget(),
                            PalnItemWidget(),
                            PalnItemWidget(),
                          ],
                        ),
                        margin: index == titlePlanList.length - 1 ? 0 : 16,
                        onTap: () {
                          context.pushNamed(
                            AutiLabRoutes.payPackagesScreen,
                            extra: {
                              'title': titlePlanList[index],
                            },
                          );
                        },
                      ),
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
      ),
    );
  }
}
