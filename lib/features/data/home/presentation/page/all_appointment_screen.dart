import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/loading_indicator_widget.dart';
import 'package:autilab_project/features/data/home/data/model/newappointment_model.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_bloc.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../common/widgets/item_not_found_widget.dart';
import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../core/constants/color_constant.dart';
import '../../../../../core/constants/constant_routes.dart';
import '../../../../../core/constants/theme_constant.dart';
import '../../../../../presentation/screens/not_connection_screen.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../widgets/new_appointment_card_widget.dart';
import '../bloc/home_event.dart';

class DateTimeSchedule {
  String date;
  String time;
  DateTimeSchedule({
    required this.date,
    required this.time,
  });
}

class AllAppointmentScreen extends StatefulWidget {
  const AllAppointmentScreen({super.key});

  @override
  State<AllAppointmentScreen> createState() => _AllAppointmentScreenState();
}

class _AllAppointmentScreenState extends State<AllAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationHelper animationHelper;

  List<NewappointmentModel> approvedList = [];
  List<NewappointmentModel> cancelledList = [];
  List<NewappointmentModel> pendingList = [];

  List<DateTimeSchedule> dateTimeApprovedList = [];
  List<DateTimeSchedule> dateTimeCancelledList = [];
  List<DateTimeSchedule> dateTimePendingList = [];

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
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeFetchData) {
          state.homeResponse.fold(
            (l) {},
            (response) {
              //Control list values based on status newappointmentModel
              for (var element in response) {
                for (var element2 in element.newappointmentModel) {
                  // Parse the appointment date
                  DateTime date = DateTime.parse(element2.workSchedule.date);

                  // Format date as "Day, d Month"
                  String formattedDate = DateFormat('EEE، d MMM').format(date);

                  // Parse and combine date with start time
                  DateTime time = DateTime.parse(
                      "${element2.workSchedule.date} ${element2.workSchedule.starttime}");

                  // Format time as "HH:mm"
                  String formattedTime = DateFormat('HH:mm').format(time);

                  // Categorize appointments based on status
                  if (element2.status == 'APPROVED') {
                    approvedList.add(element2);
                    dateTimeApprovedList.add(DateTimeSchedule(
                        date: formattedDate, time: formattedTime));
                  } else if (element2.status == 'CANCELLED') {
                    cancelledList.add(element2);
                    dateTimeCancelledList.add(DateTimeSchedule(
                        date: formattedDate, time: formattedTime));
                  } else {
                    pendingList.add(element2);
                    dateTimePendingList.add(DateTimeSchedule(
                        date: formattedDate, time: formattedTime));
                  }
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
          return state.homeResponse.fold(
            (l) {
              return NotConnectionInternetScreen(
                onChange: () async {
                  context.read<HomeBloc>().add(DisplayHomeContent());
                },
              );
            },
            (response) {
              return ResponsiveLayout(
                child: FadeTransition(
                  opacity: animationHelper.fadeAnimation,
                  child: DefaultTabController(
                    animationDuration: const Duration(seconds: 1),
                    length: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        bool isMobile() {
                          if (constraints.maxWidth < 600) {
                            return true;
                          } else {
                            return false;
                          }
                        }

                        return Scaffold(
                          appBar: AppBar(
                            leadingWidth: double.infinity,
                            leading: appBarWidget(
                              context: context,
                              title: 'All Appointment',
                              isIcon: true,
                              isMobile: isMobile(),
                            ),
                            bottom: PreferredSize(
                              preferredSize:
                                  Size.fromHeight(isMobile() ? 70 : 120),
                              child: Container(
                                width: double.infinity,
                                color: AutilabColor.white,
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  height: isMobile() ? 50 : 72,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: AutilabColor.lightGray,
                                    borderRadius: BorderRadius.circular(
                                        isMobile() ? 16 : 24),
                                  ),
                                  child: TabBar(
                                    labelStyle:
                                        AutilabTextStyle.small18_400.copyWith(
                                      color: Colors.black,
                                    ),
                                    dividerColor: Colors.transparent,
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          isMobile() ? 16 : 24),
                                      color: AutilabColor.bb,
                                    ),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    tabs: [
                                      FittedBox(
                                        child: Text(
                                          'Approved',
                                          style: AutilabTextStyle.small16_400
                                              .copyWith(
                                                  fontSize:
                                                      isMobile() ? 16 : 24),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          'Cancelled',
                                          style: AutilabTextStyle.small16_400
                                              .copyWith(
                                                  fontSize:
                                                      isMobile() ? 16 : 24),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          'Pending',
                                          style: AutilabTextStyle.small16_400
                                              .copyWith(
                                                  fontSize:
                                                      isMobile() ? 16 : 24),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          body: SafeArea(
                            child: TabBarView(
                              children: [
                                if (approvedList.isNotEmpty) ...{
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: approvedList.length,
                                    padding: AutilabMargin.marginFullScreen,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: isMobile() ? 256 : 388,
                                        child: NewAppointmentsCardWidget(
                                          color: const Color(0xff50DD81),
                                          isMobile: isMobile(),
                                          doctorName:
                                              '${approvedList[index].doctorModel.doctorUser.firstName} ${approvedList[index].doctorModel.doctorUser.lastName}',
                                          doctorSpecialty: approvedList[index]
                                                  .doctorModel
                                                  .doctorSpecialities[0]
                                                  .name
                                                  .isNotEmpty
                                              ? approvedList[index]
                                                  .doctorModel
                                                  .doctorSpecialities[0]
                                                  .name
                                              : '',
                                          title: 'Approved',
                                          image: 'assets/images/doctor2.jpg',
                                          statusIcon:
                                              'assets/icons/done_icon.svg',
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          raiteOnTap: () {},
                                          date:
                                              dateTimeApprovedList[index].date,
                                          time:
                                              dateTimeApprovedList[index].time,
                                          onTap: () {
                                            context.pushNamed(
                                              AutiLabRoutes
                                                  .detailAppointmentScreen,
                                              extra: {
                                                'doctorModel':
                                                    approvedList[index]
                                                        .doctorModel,
                                                'newappointmentModel':
                                                    pendingList[index],
                                                'doctorName':
                                                    '${approvedList[index].doctorModel.doctorUser.firstName} ${approvedList[index].doctorModel.doctorUser.lastName}',
                                                'doctorSpecialty':
                                                    approvedList[index]
                                                        .doctorModel
                                                        .doctorSpecialities[0]
                                                        .name,
                                                'statusColor':
                                                    const Color(0xff50DD81),
                                                'statusIcon':
                                                    'assets/icons/done_icon.svg',
                                                'image':
                                                    'assets/images/doctor2.jpg',
                                                'title': 'Approved',
                                                'descriptionStatus':
                                                    'Your Appointment Has Been Approved',
                                                'dateTimeSchedule':
                                                    DateTimeSchedule(
                                                  date: dateTimeApprovedList[
                                                          index]
                                                      .date,
                                                  time: dateTimeApprovedList[
                                                          index]
                                                      .time,
                                                ),
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                } else ...{
                                  ItemNotFoundWidget(isMobile: isMobile()),
                                },
                                if (cancelledList.isNotEmpty) ...{
                                  ListView.builder(
                                    itemCount: cancelledList.length,
                                    padding: AutilabMargin.marginFullScreen,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: isMobile() ? 256 : 388,
                                        child: NewAppointmentsCardWidget(
                                          isMobile: isMobile(),
                                          color: const Color(0xffFF6363),
                                          title: 'Cancelled',
                                          image:
                                              'assets/images/doctor_image.jpg',
                                          statusIcon:
                                              'assets/icons/close_icon.svg',
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          raiteOnTap: () {},
                                          date:
                                              dateTimeCancelledList[index].date,
                                          time:
                                              dateTimeCancelledList[index].time,
                                          doctorName:
                                              '${approvedList[index].doctorModel.doctorUser.firstName} ${approvedList[index].doctorModel.doctorUser.lastName}',
                                          doctorSpecialty: approvedList[index]
                                                  .doctorModel
                                                  .doctorSpecialities[0]
                                                  .name
                                                  .isNotEmpty
                                              ? approvedList[index]
                                                  .doctorModel
                                                  .doctorSpecialities[0]
                                                  .name
                                              : '',
                                          onTap: () {
                                            context.pushNamed(
                                              AutiLabRoutes
                                                  .detailAppointmentScreen,
                                              extra: {
                                                'doctorModel':
                                                    cancelledList[index]
                                                        .doctorModel,
                                                'newappointmentModel':
                                                    pendingList[index],
                                                'doctorName':
                                                    '${cancelledList[index].doctorModel.doctorUser.firstName} ${cancelledList[index].doctorModel.doctorUser.lastName}',
                                                'doctorSpecialty':
                                                    cancelledList[index]
                                                        .doctorModel
                                                        .doctorSpecialities[0]
                                                        .name,
                                                'statusColor':
                                                    const Color(0xffFF6363),
                                                'statusIcon':
                                                    'assets/icons/close_icon.svg',
                                                'image':
                                                    'assets/images/doctor_image.jpg',
                                                'title': 'Cancelled',
                                                'descriptionStatus':
                                                    'Your Appointment Has Been Canceled',
                                                'dateTimeSchedule':
                                                    DateTimeSchedule(
                                                  date: dateTimeCancelledList[
                                                          index]
                                                      .date,
                                                  time: dateTimeCancelledList[
                                                          index]
                                                      .time,
                                                ),
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                } else ...{
                                  ItemNotFoundWidget(isMobile: isMobile()),
                                },
                                if (pendingList.isNotEmpty) ...{
                                  ListView.builder(
                                    itemCount: pendingList.length,
                                    padding: AutilabMargin.marginFullScreen,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: isMobile() ? 256 : 388,
                                        child: NewAppointmentsCardWidget(
                                          isMobile: isMobile(),
                                          color: AutilabColor.gray,
                                          title: 'Pending',
                                          image: 'assets/images/doctor3.png',
                                          statusIcon:
                                              'assets/icons/minimize_icon.svg',
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          doctorName:
                                              '${approvedList[index].doctorModel.doctorUser.firstName} ${approvedList[index].doctorModel.doctorUser.lastName}',
                                          doctorSpecialty: approvedList[index]
                                                  .doctorModel
                                                  .doctorSpecialities[0]
                                                  .name
                                                  .isNotEmpty
                                              ? approvedList[index]
                                                  .doctorModel
                                                  .doctorSpecialities[0]
                                                  .name
                                              : '',
                                          raiteOnTap: () {},
                                          date: dateTimePendingList[index].date,
                                          time: dateTimePendingList[index].time,
                                          onTap: () {
                                            context.pushNamed(
                                              AutiLabRoutes
                                                  .detailAppointmentScreen,
                                              extra: {
                                                'doctorModel':
                                                    pendingList[index]
                                                        .doctorModel,
                                                'newappointmentModel':
                                                    pendingList[index],
                                                'doctorName':
                                                    '${pendingList[index].doctorModel.doctorUser.firstName} ${pendingList[index].doctorModel.doctorUser.lastName}',
                                                'doctorSpecialty':
                                                    pendingList[index]
                                                        .doctorModel
                                                        .doctorSpecialities[0]
                                                        .name,
                                                'statusColor':
                                                    AutilabColor.gray,
                                                'statusIcon':
                                                    'assets/icons/minimize_icon.svg',
                                                'image':
                                                    'assets/images/doctor3.png',
                                                'title': 'Pending',
                                                'descriptionStatus':
                                                    'Your Appointment Is Being Reviewed',
                                                'dateTimeSchedule':
                                                    DateTimeSchedule(
                                                  date:
                                                      dateTimePendingList[index]
                                                          .date,
                                                  time:
                                                      dateTimePendingList[index]
                                                          .time,
                                                ),
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                } else ...{
                                  ItemNotFoundWidget(isMobile: isMobile()),
                                }
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
