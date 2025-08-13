import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/plan_box_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_bloc.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_state.dart';
import 'package:autilab_project/features/data/home/widgets/new_appointment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widgets/test_result_widget.dart';
import '../../../../../core/constants/color_constant.dart';
import '../../../../../presentation/screens/not_connection_screen.dart';
import '../../../../../utils/Lists/package_info_list.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../utils/functions/appointment_check_status_function.dart';
import '../../../../../utils/functions/cacheimahe_function.dart';
import '../../../doctor/page/nearby_center_details_screen.dart';
import '../../../doctor/widgets/specialty_list_widget.dart';
import '../../widgets/plan_item_widget.dart';
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
            (l) {
              print(l);
            },
            (r) {},
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AutilabColor.bb,
            ),
          );
        }
        if (state is HomeErrorHandling) {
          return NotConnectionInternetScreen(
            onChange: () async {
              context.read<HomeBloc>().add(DisplayHomeContent());
            },
          );
        }
        if (state is HomeFetchData) {
          return state.homeResponse.fold((l) {
            return NotConnectionInternetScreen(
              onChange: () async {
                context.read<HomeBloc>().add(DisplayHomeContent());
              },
            );
          }, (response) {
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
                              child: SizedBox(
                                height: isMobile() ? 240 : 370,
                                child: ListView.builder(
                                  itemCount: response.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: index == 0 ? 20 : 12,
                                        right: index == response.length - 1
                                            ? 8
                                            : 0,
                                      ),
                                      child: SizedBox(
                                        width: isMobile() ? 320 : 643,
                                        child: NewAppointmentsCardWidget(
                                          isMobile: isMobile(),
                                          color: statusCheckColor(response[
                                                      index]
                                                  .newappointmentModel[index]
                                                  .status)
                                              .$3,
                                          title: statusCheckColor(response[
                                                      index]
                                                  .newappointmentModel[index]
                                                  .status)
                                              .$2,
                                          statusIcon: statusCheckColor(response[
                                                      index]
                                                  .newappointmentModel[index]
                                                  .status)
                                              .$1,
                                          image:
                                              'assets/images/doctor_image.jpg',
                                          doctorName:
                                              '${response[index].newappointmentModel[index].doctorModel.doctorUser.firstName} ${response[index].newappointmentModel[index].doctorModel.doctorUser.lastName}',
                                          doctorSpecialty: response[index]
                                              .newappointmentModel[index]
                                              .doctorModel
                                              .doctorSpecialities[index]
                                              .name,
                                          margin: EdgeInsets.zero,
                                          raiteOnTap: () {},
                                          onTap: () {
                                            context.pushNamed(
                                              AutiLabRoutes
                                                  .detailAppointmentScreen,
                                              extra: {
                                                'doctorModel': response[index]
                                                    .newappointmentModel[index]
                                                    .doctorModel,
                                                'doctorName':
                                                    '${response[index].newappointmentModel[index].doctorModel.doctorUser.firstName} ${response[index].newappointmentModel[index].doctorModel.doctorUser.lastName}',
                                                'doctorSpecialty': response[
                                                        index]
                                                    .newappointmentModel[index]
                                                    .doctorModel
                                                    .doctorSpecialities[index]
                                                    .name,
                                                'statusColor': statusCheckColor(
                                                        response[index]
                                                            .newappointmentModel[
                                                                index]
                                                            .status)
                                                    .$3,
                                                'statusIcon': statusCheckColor(
                                                        response[index]
                                                            .newappointmentModel[
                                                                index]
                                                            .status)
                                                    .$1,
                                                'image':
                                                    'assets/images/doctor_image.jpg',
                                                'title': statusCheckColor(
                                                        response[index]
                                                            .newappointmentModel[
                                                                index]
                                                            .status)
                                                    .$2,
                                                'descriptionStatus':
                                                    statusCheckColor(response[
                                                                index]
                                                            .newappointmentModel[
                                                                index]
                                                            .status)
                                                        .$4,
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
                                  title: 'Recent Visited',
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
                              child: SpecialtiesListWidget(
                                height: isMobile() ? 113 : 180,
                                width: isMobile() ? 112 : 180,
                                widthImage: isMobile() ? 56 : 76,
                                heightImage: isMobile() ? 56 : 76,
                                radius: isMobile() ? 24 : 40,
                                textStyle: isMobile()
                                    ? AutilabTextStyle.small14_400
                                    : AutilabTextStyle.small20_400,
                                recentModel: response[0].recentVisitedModel,
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
                                                isMobile() ? 143 : 372,
                                                context),
                                            cacheHeight: cacheImageFunction(
                                                isMobile() ? 140 : 229,
                                                context),
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
                                  intelligenceData:
                                      response[0].intelligenceTestModel,
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
                                  itemCount: titlePlanList.length,
                                  itemBuilder: (context, index) => SizedBox(
                                    width: isMobile() ? 340 : 478,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: index == 0 ? 20 : 0,
                                          right:
                                              index == titlePlanList.length - 1
                                                  ? 10
                                                  : 0),
                                      child: PlanBoxWidget(
                                        isMobile: isMobile(),
                                        title: titlePlanList[index],
                                        description: descriptionPlanList[index],
                                        titleButton: 'Buy',
                                        widget: [
                                          PalnItemWidget(
                                            isMobile: isMobile(),
                                            title:
                                                'Full access to the tools section',
                                          ),
                                          PalnItemWidget(
                                            isMobile: isMobile(),
                                            title: 'Access to aptitude test',
                                          ),
                                          PalnItemWidget(
                                            isMobile: isMobile(),
                                            title: 'Access to personality test',
                                          ),
                                          PalnItemWidget(
                                            isMobile: isMobile(),
                                            title:
                                                'Unlimited appointment booking',
                                          ),
                                          PalnItemWidget(
                                            isMobile: isMobile(),
                                            title: 'Access to nearby centers',
                                          ),
                                          PalnItemWidget(
                                            isMobile: isMobile(),
                                            title:
                                                'Doctor appointment booking discount',
                                          ),
                                        ],
                                        margin:
                                            index == titlePlanList.length - 1
                                                ? 0
                                                : 16,
                                        onTap: () {
                                          int price = 0;
                                          if (index == 1) {
                                            price = 99;
                                          } else {
                                            price = 299;
                                          }
                                          context.pushNamed(
                                            AutiLabRoutes.payPackagesScreen,
                                            extra: {
                                              'title': titlePlanList[index],
                                              'description':
                                                  descriptionPlanList[index],
                                              'price': price,
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
          });
        }
        return const SizedBox();
      },
    );
  }
}
