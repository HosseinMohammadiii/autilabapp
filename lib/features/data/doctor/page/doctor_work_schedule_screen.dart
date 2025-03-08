import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constant_routes.dart';
import '../../../../utils/functions/animation_control.dart';
import '../widgets/button_card.dart';

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

  List<String> timeAvailable = [
    '7:00 AM',
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '13:00 PM',
    '14:00 PM',
    '15:00 PM',
    '16:00 PM',
    '17:00 PM',
    '18:00 PM',
  ];

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
                  child: Container(
                    width: double.infinity,
                    height: 136,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: AutilabMargin.marginFullScreen,
                    decoration: BoxDecoration(
                      color: AutilabColor.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/doctor_image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      'Dr. Sophia Martinez',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      'Psychotherapy',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: CustomButtonWidget(
                                      onTap: () {
                                        context.pushNamed(AutiLabRoutes
                                            .doctorInformationScreen);
                                      },
                                      height: 30,
                                      width: 80,
                                      margin: const EdgeInsets.all(0),
                                      color: AutilabColor.yellow,
                                      text: 'Info',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                  const Spacer(),
                                  ButtonCard(
                                    icon: 'assets/icons/messages.svg',
                                    onTap: () {
                                      context.pushNamed(
                                          AutiLabRoutes.doctorMessageScreen);
                                    },
                                  ),
                                  ButtonCard(
                                    icon: 'assets/icons/heart.svg',
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                  child: _displayTitleSections(
                    context,
                    'assets/icons/calendar_tick_icon.svg',
                    'Available Date',
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
                                    fontSize: 18,
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
                const SliverToBoxAdapter(
                  child: CalendarGrid(),
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
                SliverToBoxAdapter(
                  child: _displayTitleSections(
                    context,
                    'assets/icons/clock_icon.svg',
                    'Available Times',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                SliverPadding(
                  padding: AutilabMargin.marginFullScreen,
                  sliver: SliverGrid.builder(
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisExtent: 30,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AutilabColor.bb,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          timeAvailable[index],
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      );
                    },
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

  Widget _displayTitleSections(
    BuildContext context,
    String icon,
    String title,
  ) {
    return Padding(
      padding: AutilabMargin.marginFullScreen,
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
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

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

  List<DateTime?> generateMonthDays(int year, int month) {
    List<DateTime?> days = [];

    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int startWeekday = firstDayOfMonth.weekday;

    int emptySlots = startWeekday % 7;
    days.addAll(List.filled(emptySlots, null));

    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(year, month, i));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<DateTime?> days = generateMonthDays(now.year, now.month);

    return Container(
      height: 350,
      padding: const EdgeInsets.all(16),
      margin: AutilabMargin.marginFullScreen,
      decoration: BoxDecoration(
        color: AutilabColor.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AutilabColor.black.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Mon",
              "Tue",
              "Wed",
              "Thu",
              "Fri",
              "Sat",
              "Sun",
            ]
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: day == 'Sun'
                                  ? Colors.red
                                  : AutilabColor.black,
                            ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisExtent: 40,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: days.length,
              itemBuilder: (context, index) {
                DateTime? day = days[index];
                bool isSunday = day != null && day.weekday == 6;
                return Container(
                  decoration: BoxDecoration(
                    color: (day != null && !isSunday)
                        ? AutilabColor.bb
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      day != null ? DateFormat('d').format(day) : '',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: (day != null && !isSunday)
                                ? AutilabColor.black
                                : Colors.red,
                          ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
