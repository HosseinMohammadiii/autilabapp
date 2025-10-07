import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/data/model/doctor_model.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';
import 'package:autilab_project/utils/Lists/time_date_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../widgets/calendar_box_widget.dart';
import '../../widgets/doctor_container_box_widget.dart';
import '../../widgets/select_time_widget.dart';
import 'nearby_center_details_screen.dart';

// ignore: must_be_immutable
class DoctorWorkScheduleScreen extends StatefulWidget {
  DoctorWorkScheduleScreen({
    super.key,
    this.isLike = false,
    this.doctorUser,
    this.specialty,
  });
  bool? isLike;
  final DoctorUser? doctorUser;
  final RecentVisitedModel? specialty;

  @override
  State<DoctorWorkScheduleScreen> createState() =>
      _DoctorWorkScheduleScreenState();
}

class _DoctorWorkScheduleScreenState extends State<DoctorWorkScheduleScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  String _monthName = '';
  String selectDate = '';
  String doctorFullName = '';

  bool isOpen = false;

  int montNumber = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    _monthName = DateFormat.MMMM().format(DateTime.now());
    doctorFullName =
        '${widget.doctorUser?.firstName} ${widget.doctorUser?.lastName}';
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DoctorWorkScheduleScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile() {
          if (constraints.maxWidth < 600) {
            return true;
          } else {
            return false;
          }
        }

        return ResponsiveLayout(
          child: FadeTransition(
            opacity: animationHelper.fadeAnimation,
            child: Scaffold(
              appBar: appBarWidget(
                context: context,
                title: 'Work Schedule',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 32,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: DoctorBox(
                          isMobile: isMobile(),
                          user: widget.doctorUser,
                          isLike: widget.isLike,
                          specialty: widget.specialty,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 48,
                        ),
                      ),
                      SliverPadding(
                        padding: AutilabMargin.marginFullScreen,
                        sliver: SliverToBoxAdapter(
                          child: TitleAndIconWidget(
                            isMobile: isMobile(),
                            icon: 'assets/icons/calendar_tick_icon.svg',
                            title: 'Available Date',
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
                          padding: AutilabMargin.marginFullScreen,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isOpen = !isOpen;
                              });
                            },
                            child: Row(
                              spacing: 14,
                              children: [
                                Text(
                                  _monthName,
                                  style: AutilabTextStyle.small18_400.copyWith(
                                    fontSize: isMobile() ? 18 : 24,
                                  ),
                                ),
                                isOpen
                                    ? SvgPicture.asset(
                                        'assets/icons/arrow_up.svg',
                                        width: isMobile() ? 16 : 24,
                                        height: isMobile() ? 16 : 24,
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/arrow_down.svg',
                                        width: isMobile() ? 16 : 24,
                                        height: isMobile() ? 16 : 24,
                                      ),
                              ],
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
                        child: Stack(
                          children: [
                            CalendarGrid(
                              isMobile: isMobile(),
                              date: montNumber,
                              onTap: (day, id) {
                                setState(() {
                                  selectDate = DateFormat('EEE d')
                                      .format(day ?? DateTime.now());
                                });
                              },
                              isSelect: false,
                            ),
                            Visibility(
                              visible: isOpen,
                              child: Container(
                                width: isMobile() ? 130 : 167,
                                padding: const EdgeInsets.all(12),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF6F6F6),
                                  border: Border.all(color: AutilabColor.blue),
                                  borderRadius: BorderRadius.circular(
                                      isMobile() ? 16 : 24),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: montNameList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isOpen = false;
                                              _monthName = montNameList[index];
                                              montNumber = index;
                                              selectDate = '';
                                            });
                                          },
                                          child: Text(
                                            montNameList[index],
                                            style: AutilabTextStyle.small16_400
                                                .copyWith(
                                              fontSize: isMobile() ? 16 : 24,
                                            ),
                                          ),
                                        ),
                                        if (index < montNameList.length - 1)
                                          const Divider(
                                            thickness: 1,
                                            color: AutilabColor.gray,
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 24,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          spacing: 8,
                          children: [
                            _displayIsAvailableWidget(
                              context,
                              'Open For Booking',
                              AutilabColor.bb,
                              isMobile(),
                            ),
                            _displayIsAvailableWidget(
                              context,
                              'This Is A Non-Working Day',
                              AutilabColor.lightGray,
                              isMobile(),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 48,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: AutilabMargin.marginFullScreen,
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
                      SliverPadding(
                        padding: AutilabMargin.marginFullScreen,
                        sliver: SliverToBoxAdapter(
                          child: TitleAndIconWidget(
                            isMobile: isMobile(),
                            icon: 'assets/icons/clock_icon.svg',
                            title: 'Available Times',
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      SliverPadding(
                        padding: AutilabMargin.marginFullScreen,
                        sliver: SelectTimeWidget(
                          isMobile: isMobile(),
                          backgroundColor: AutilabColor.lightGray,
                          onTap: (time) {},
                          isSelect: false,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          spacing: 8,
                          children: [
                            _displayIsAvailableWidget(
                              context,
                              'Open For Booking',
                              AutilabColor.bb,
                              isMobile(),
                            ),
                            _displayIsAvailableWidget(
                              context,
                              'This Is A Non-Working Day',
                              AutilabColor.lightGray,
                              isMobile(),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

//Display Available Or NotAvailable text
  Widget _displayIsAvailableWidget(
    BuildContext context,
    String title,
    Color color,
    bool isMobile,
  ) {
    return Padding(
      padding: AutilabMargin.marginFullScreen,
      child: Row(
        children: [
          Container(
            width: isMobile ? 20 : 32,
            height: isMobile ? 20 : 32,
            margin: EdgeInsets.only(right: isMobile ? 4 : 8),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            title,
            style: AutilabTextStyle.small14_400.copyWith(
              fontSize: isMobile ? 14 : 24,
            ),
          ),
        ],
      ),
    );
  }
}
