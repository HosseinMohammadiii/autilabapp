import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/display_title_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utils/functions/animation_control.dart';
import '../widgets/calendar_box_widget.dart';
import '../widgets/doctor_container_box_widget.dart';
import '../widgets/select_time_widget.dart';

class DoctorWorkScheduleScreen extends StatefulWidget {
  const DoctorWorkScheduleScreen({super.key});

  @override
  State<DoctorWorkScheduleScreen> createState() =>
      _DoctorWorkScheduleScreenState();
}

class _DoctorWorkScheduleScreenState extends State<DoctorWorkScheduleScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  String _monthName = '';

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
                const SliverToBoxAdapter(
                  child: DoctorBox(),
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
                    child: Row(
                      children: [
                        Text(
                          _monthName,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded),
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
                  child: CalendarGrid(
                    onTap: (day) {},
                    isSelect: false,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _displayIsAvailableWidget(
                          context, 'Available', AutilabColor.bb),
                      const SizedBox(
                        height: 8,
                      ),
                      _displayIsAvailableWidget(
                          context, 'Not Available', AutilabColor.lightGray),
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
                          context, 'Available', AutilabColor.bb),
                      _displayIsAvailableWidget(
                          context, 'Not Available', AutilabColor.lightGray),
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
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
