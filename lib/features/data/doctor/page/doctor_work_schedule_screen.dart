import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/display_title_section_widget.dart';
import 'package:autilab_project/utils/Lists/time_date_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../utils/functions/animation_control.dart';
import '../widgets/calendar_box_widget.dart';
import '../widgets/doctor_container_box_widget.dart';
import '../widgets/select_time_widget.dart';

// ignore: must_be_immutable
class DoctorWorkScheduleScreen extends StatefulWidget {
  DoctorWorkScheduleScreen({
    super.key,
    this.isLike = false,
  });
  bool? isLike;

  @override
  State<DoctorWorkScheduleScreen> createState() =>
      _DoctorWorkScheduleScreenState();
}

class _DoctorWorkScheduleScreenState extends State<DoctorWorkScheduleScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  String _monthName = '';
  String selectDate = '';

  bool isOpen = false;

  int montNumber = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    _monthName = DateFormat.MMMM().format(DateTime.now());
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
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, title: 'Work Schedule', isIcon: true),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 48,
                  ),
                ),
                SliverToBoxAdapter(
                  child: DoctorBox(
                    isLike: widget.isLike,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 48,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: DisplayTitleSection(
                    icon: 'assets/icons/calendar_tick_icon.svg',
                    title: 'Available Date',
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
                            style: AutilabTextStyle.small18_400,
                          ),
                          isOpen
                              ? SvgPicture.asset(
                                  'assets/icons/arrow_up.svg',
                                  width: 16,
                                  height: 16,
                                )
                              : SvgPicture.asset(
                                  'assets/icons/arrow_down.svg',
                                  width: 16,
                                  height: 16,
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
                        date: montNumber,
                        onTap: (day) {
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
                          width: 130,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffF6F6F6),
                            border: Border.all(color: AutilabColor.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: montNameList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                      style: AutilabTextStyle.small16_400,
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
                          context, 'Open For Booking', AutilabColor.bb),
                      _displayIsAvailableWidget(
                          context, 'Already Booked', AutilabColor.lightGray),
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
                const SliverToBoxAdapter(
                  child: DisplayTitleSection(
                    icon: 'assets/icons/clock_icon.svg',
                    title: 'Available Times',
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
                          context, 'Open For Booking', AutilabColor.bb),
                      _displayIsAvailableWidget(
                          context, 'Already Booked', AutilabColor.lightGray),
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
    );
  }

//Display Available Or NotAvailable text
  Widget _displayIsAvailableWidget(
    BuildContext context,
    String title,
    Color color,
  ) {
    return Padding(
      padding: AutilabMargin.marginFullScreen,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            title,
            style: AutilabTextStyle.small14_400,
          ),
        ],
      ),
    );
  }
}
