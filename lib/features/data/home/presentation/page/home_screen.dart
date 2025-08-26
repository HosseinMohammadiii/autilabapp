import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/plan_box_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/home/data/model/plan_model.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_bloc.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_state.dart';
import 'package:autilab_project/features/data/home/presentation/page/all_appointment_screen.dart';
import 'package:autilab_project/features/data/home/widgets/new_appointment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../common/widgets/loading_indicator_widget.dart';
import '../../../../../common/widgets/test_result_widget.dart';
import '../../../../../core/constants/color_constant.dart';
import '../../../../../presentation/screens/not_connection_screen.dart';
import '../../../../../utils/Lists/package_info_list.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../utils/functions/appointment_check_status_function.dart';
import '../../../../../utils/functions/cacheimahe_function.dart';
import '../../../doctor/presentation/page/nearby_center_details_screen.dart';
import '../../../doctor/widgets/specialty_list_widget.dart';
import '../../data/model/intelligence_test_model.dart';
import '../../data/model/newappointment_model.dart';
import '../../data/model/recent_visited_model.dart';
import '../bloc/home_event.dart';

class StatusClass {
  Color statusColor;
  String statusIcon;
  String title;
  String descriptionStatus;
  //StatusClass constructor
  StatusClass(
    this.statusColor,
    this.statusIcon,
    this.title,
    this.descriptionStatus,
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  List<NewappointmentModel> newappointmentModel = [];
  List<RecentVisitedModel> recentVisitedModel = [];
  List<IntelligenceTestModel> intelligenceTestModel = [];
  List<PlanModel> planModel = [];

  List<String> scheduleDate = [];
  List<String> scheduleTime = [];
  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    BlocProvider.of<HomeBloc>(context).add(DisplayHomeContent());
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeFetchData) {
          state.homeResponse.fold(
            (l) {},
            (response) {
              for (var element in response) {
                newappointmentModel = element.newappointmentModel;
                recentVisitedModel = element.recentVisitedModel;
                intelligenceTestModel = element.intelligenceTestModel;
                planModel = element.planModel;
                for (var element in element.newappointmentModel) {
                  DateTime date = DateTime.parse(element.workSchedule.date);
                  DateTime time = DateTime.parse(
                      "${element.workSchedule.date} ${element.workSchedule.starttime}");
                  var formatDate = DateFormat(
                    'EEE، d MMM',
                  ).format(date);
                  var formatTime = DateFormat(
                    'hh:mm',
                  ).format(time);
                  scheduleDate.add(formatDate);
                  scheduleTime.add(formatTime);
                }
              }
            },
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const LoadingProgressWidget();
        }
        if (state is HomeErrorHandling) {
          return NotConnectionInternetScreen(
            onChange: () async {
              context.read<HomeBloc>().add(DisplayHomeContent());
            },
          );
        }
        if (state is HomeFetchData) {
          return FadeTransition(
            opacity: animationHelper.fadeAnimation,
            child: RefreshIndicator(
              color: AutilabColor.bb,
              onRefresh: () async {
                context.read<HomeBloc>().add(DisplayHomeContent());
              },
              child: Scaffold(
                body: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      bool isMobile() {
                        if (constraints.maxWidth < 600) {
                          return true;
                        } else {
                          return false;
                        }
                      }

                      return CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: AutilabMargin.marginFullScreen,
                            sliver: SliverToBoxAdapter(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'New Appointments',
                                    style: AutilabTextStyle.small20_400
                                        .copyWith(
                                            fontSize: isMobile() ? 20 : 32),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'See All',
                                      style: AutilabTextStyle.medium14_500
                                          .copyWith(
                                        color: AutilabColor.blue,
                                        fontSize: isMobile() ? 14 : 20,
                                      ),
                                    ),
                                    onTap: () {
                                      context.pushNamed(
                                          AutiLabRoutes.allAppointmentScreen);
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
                            child: Visibility(
                              visible: newappointmentModel.isNotEmpty,
                              replacement: Container(
                                padding: const EdgeInsets.all(12),
                                margin: AutilabMargin.marginFullScreen,
                                decoration: BoxDecoration(
                                  color: AutilabColor.primary,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffECF0FF),
                                        border:
                                            Border.all(color: AutilabColor.bb),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'You Don’t Have Any Appointment',
                                                  textAlign: TextAlign.center,
                                                  style: AutilabTextStyle
                                                      .medium14_500
                                                      .copyWith(
                                                    fontSize:
                                                        isMobile() ? 14 : 28,
                                                  ),
                                                ),
                                                Text(
                                                  'You can view all appointment from the button below',
                                                  textAlign: TextAlign.center,
                                                  style: AutilabTextStyle
                                                      .small12_400
                                                      .copyWith(
                                                    fontSize:
                                                        isMobile() ? 12 : 20,
                                                    color: AutilabColor.gray,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/notAvailbleDoctor.svg',
                                            width: isMobile() ? 152 : 345,
                                            height: isMobile() ? 113 : 258,
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomButtonWidget(
                                      isMobile: isMobile(),
                                      onTap: () {
                                        context.goNamed(
                                            AutiLabRoutes.doctorScreen);
                                      },
                                      height: 50,
                                      margin: const EdgeInsets.only(top: 12),
                                      color: AutilabColor.bb,
                                      text: 'Make Appointment',
                                      textStyle: AutilabTextStyle.small18_400,
                                    ),
                                  ],
                                ),
                              ),
                              child: SizedBox(
                                height: isMobile() ? 240 : 370,
                                child: ListView.builder(
                                  itemCount: newappointmentModel.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: index == 0 ? 20 : 12,
                                        right: index ==
                                                newappointmentModel.length - 1
                                            ? 8
                                            : 0,
                                      ),
                                      child: SizedBox(
                                        width: isMobile() ? 320 : 643,
                                        child: NewAppointmentsCardWidget(
                                          date: scheduleDate[index],
                                          time: scheduleTime[index],
                                          isMobile: isMobile(),
                                          color: statusCheckColor(
                                                  newappointmentModel[index]
                                                      .status)
                                              .$3,
                                          title: statusCheckColor(
                                                  newappointmentModel[index]
                                                      .status)
                                              .$2,
                                          statusIcon: statusCheckColor(
                                                  newappointmentModel[index]
                                                      .status)
                                              .$1,
                                          image:
                                              'assets/images/doctor_image.jpg',
                                          doctorName:
                                              '${newappointmentModel[index].doctorModel.doctorUser.firstName} ${newappointmentModel[index].doctorModel.doctorUser.lastName}',
                                          doctorSpecialty:
                                              newappointmentModel[index]
                                                      .doctorModel
                                                      .doctorSpecialities[0]
                                                      .name
                                                      .isNotEmpty
                                                  ? newappointmentModel[index]
                                                      .doctorModel
                                                      .doctorSpecialities[0]
                                                      .name
                                                  : '',
                                          margin: EdgeInsets.zero,
                                          raiteOnTap: () {},
                                          onTap: () {
                                            context.pushNamed(
                                              AutiLabRoutes
                                                  .detailAppointmentScreen,
                                              extra: {
                                                'doctorModel':
                                                    newappointmentModel[index]
                                                        .doctorModel,
                                                'newappointmentModel':
                                                    newappointmentModel[index],
                                                'doctorName':
                                                    '${newappointmentModel[index].doctorModel.doctorUser.firstName} ${newappointmentModel[index].doctorModel.doctorUser.lastName}',
                                                'doctorSpecialty':
                                                    newappointmentModel[index]
                                                        .doctorModel
                                                        .doctorSpecialities[0]
                                                        .name,
                                                'statusColor': statusCheckColor(
                                                        newappointmentModel[
                                                                index]
                                                            .status)
                                                    .$3,
                                                'statusIcon': statusCheckColor(
                                                        newappointmentModel[
                                                                index]
                                                            .status)
                                                    .$1,
                                                'image':
                                                    'assets/images/doctor_image.jpg',
                                                'title': statusCheckColor(
                                                        newappointmentModel[
                                                                index]
                                                            .status)
                                                    .$2,
                                                'descriptionStatus':
                                                    statusCheckColor(
                                                            newappointmentModel[
                                                                    index]
                                                                .status)
                                                        .$4,
                                                'dateTimeSchedule':
                                                    DateTimeSchedule(
                                                  date: scheduleDate[index],
                                                  time: scheduleTime[index],
                                                ),
                                              },
                                            );
                                          },
                                        ),
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
                          SliverPadding(
                            padding: AutilabMargin.marginFullScreen
                                .copyWith(left: 16),
                            sliver: SliverToBoxAdapter(
                              child: Visibility(
                                visible: recentVisitedModel.isNotEmpty,
                                child: TitleAndIconWidget(
                                  isShowIcon: false,
                                  title: 'Recent Visited',
                                  textStyle: AutilabTextStyle.small20_400
                                      .copyWith(fontSize: isMobile() ? 20 : 32),
                                ),
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 24,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Visibility(
                              visible: recentVisitedModel.isNotEmpty,
                              child: SpecialtiesListWidget(
                                height: isMobile() ? 113 : 180,
                                width: isMobile() ? 112 : 180,
                                widthImage: isMobile() ? 56 : 76,
                                heightImage: isMobile() ? 56 : 76,
                                radius: isMobile() ? 24 : 40,
                                itemCount: recentVisitedModel.length,
                                textStyle: isMobile()
                                    ? AutilabTextStyle.small14_400
                                    : AutilabTextStyle.small20_400,
                                specialtyModel: recentVisitedModel,
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 48,
                            ),
                          ),
                          SliverPadding(
                            padding: AutilabMargin.marginFullScreen
                                .copyWith(left: 16),
                            sliver: SliverToBoxAdapter(
                              child: TitleAndIconWidget(
                                isShowIcon: false,
                                title: 'AutiLab Test',
                                textStyle: AutilabTextStyle.small20_400
                                    .copyWith(fontSize: isMobile() ? 20 : 32),
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
                                    color: AutilabColor.black
                                        .withValues(alpha: 0.2),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                spacing: 26,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: isMobile() ? 140 : 250,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  'AutiLab Test',
                                                  style: AutilabTextStyle
                                                      .medium20_500
                                                      .copyWith(
                                                    color: AutilabColor.blue,
                                                    fontSize:
                                                        isMobile() ? 20 : 28,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  isMobile()
                                                      ? 'Discover deeper insights into your unique personality with our autism-focused assessment.'
                                                      : 'Gain deeper insight into your unique personality traits with our autism-focused assessment.Designed with care, this tool helps you better understand your strengths, preferences, and how you relate to the world around you.',
                                                  style: isMobile()
                                                      ? AutilabTextStyle
                                                          .small14_400
                                                      : AutilabTextStyle
                                                          .small20_400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/autilab_test_image.png',
                                          width: isMobile() ? 143 : 372,
                                          height: isMobile() ? 140 : 229,
                                          cacheWidth: cacheImageFunction(
                                              isMobile() ? 143 : 372, context),
                                          cacheHeight: cacheImageFunction(
                                              isMobile() ? 140 : 229, context),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomButtonWidget(
                                    isMobile: isMobile(),
                                    onTap: () {
                                      context.pushNamed(
                                          AutiLabRoutes.typeTestsScreen);
                                    },
                                    height: 50,
                                    margin: const EdgeInsets.all(0),
                                    color: AutilabColor.bb,
                                    text: 'Take A Test',
                                    textStyle: AutilabTextStyle.small18_400
                                        .copyWith(
                                            fontSize: isMobile() ? 18 : 28),
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
                          SliverPadding(
                            padding: AutilabMargin.marginFullScreen
                                .copyWith(left: 16),
                            sliver: SliverToBoxAdapter(
                              child: TitleAndIconWidget(
                                isShowIcon: false,
                                title: 'Talent Result',
                                textStyle: AutilabTextStyle.small20_400
                                    .copyWith(fontSize: isMobile() ? 20 : 32),
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 24,
                            ),
                          ),
                          SliverPadding(
                            padding: AutilabMargin.marginFullScreen,
                            sliver: SliverToBoxAdapter(
                              child: TestResultWidget(
                                isShowTitle: false,
                                isMobile: isMobile(),
                                intelligenceData: intelligenceTestModel,
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 48,
                            ),
                          ),
                          SliverPadding(
                            padding: AutilabMargin.marginFullScreen
                                .copyWith(left: 16),
                            sliver: SliverToBoxAdapter(
                              child: TitleAndIconWidget(
                                isShowIcon: false,
                                title: 'Plan',
                                textStyle: AutilabTextStyle.small20_400
                                    .copyWith(fontSize: isMobile() ? 20 : 32),
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 24,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: isMobile() ? 465 : 560,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: planModel.length,
                                itemBuilder: (context, index) => SizedBox(
                                  width: isMobile() ? 340 : 478,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: index == 0 ? 20 : 0,
                                        right: index == titlePlanList.length - 1
                                            ? 10
                                            : 0),
                                    child: PlanBoxWidget(
                                      isMobile: isMobile(),
                                      title: planModel[index].name,
                                      description: planModel[index].description,
                                      titleButton: 'Buy',
                                      widget: planModel[index].planFeatures,
                                      // widget: [
                                      //   // PalnItemWidget(
                                      //   //   isMobile: isMobile(),
                                      //   //   title: planModel[index]
                                      //   //       .planFeatures[index]
                                      //   //       .description,
                                      //   // ),
                                      //   PalnItemWidget(
                                      //     isMobile: isMobile(),
                                      //     title: 'Access to aptitude test',
                                      //   ),
                                      //   PalnItemWidget(
                                      //     isMobile: isMobile(),
                                      //     title: 'Access to personality test',
                                      //   ),
                                      //   PalnItemWidget(
                                      //     isMobile: isMobile(),
                                      //     title:
                                      //         'Unlimited appointment booking',
                                      //   ),
                                      //   PalnItemWidget(
                                      //     isMobile: isMobile(),
                                      //     title: 'Access to nearby centers',
                                      //   ),
                                      //   PalnItemWidget(
                                      //     isMobile: isMobile(),
                                      //     title:
                                      //         'Doctor appointment booking discount',
                                      //   ),
                                      // ],
                                      margin: index == planModel.length - 1
                                          ? 0
                                          : 16,
                                      onTap: () {
                                        // int price = 0;
                                        // if (index == 1) {
                                        //   price = 99;
                                        // } else {
                                        //   price = 299;
                                        // }
                                        context.pushNamed(
                                          AutiLabRoutes.payPackagesScreen,
                                          extra: {
                                            'title': planModel[index].name,
                                            'description':
                                                planModel[index].description,
                                            'planModel': planModel[index],
                                            'planDescription':
                                                planModel[index].planFeatures,
                                            'price':
                                                planModel[index].price.toInt(),
                                          },
                                        );
                                      },
                                    ),
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
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
