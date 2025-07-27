import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class CalendarGrid extends StatefulWidget {
  const CalendarGrid({
    super.key,
    required this.onTap,
    this.isSelect = true,
    required this.date,
    this.isMobile = true,
  });
  final bool isMobile;
  final Function(DateTime? day) onTap;
  final bool? isSelect;
  final int date;

  @override
  State<CalendarGrid> createState() => _CalendarGridState();
}

class _CalendarGridState extends State<CalendarGrid> {
  DateTime? selectedDate;

  /// Generates a list of days for a given month, including empty slots for alignment
  List<DateTime?> generateMonthDays(int year, int month) {
    List<DateTime?> days = [];

    // Get the first day of the month
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    // Get the number of days in the month
    int daysInMonth = DateTime(year, month + 1, 0).day;
    // Get the starting weekday (Monday = 1, Sunday = 7)
    int startWeekday = firstDayOfMonth.weekday;

    // Add empty slots before the first day of the month to align with the calendar grid
    int emptySlots = startWeekday % 7;
    days.addAll(List.filled(emptySlots, null));

    // Add the actual days of the month
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(year, month, i));
    }

    return days;
  }

  /// Calculates the number of weeks in a given month
  int getNumberOfWeeks(int year, int month) {
    DateTime firstDay = DateTime(year, month, 1);
    DateTime lastDay = DateTime(year, month + 1, 0);

    int firstWeekday = firstDay.weekday % 7;
    int totalDays = lastDay.day;

    return ((firstWeekday + totalDays) / 7).ceil();
  }

  @override
  void initState() {
    super.initState();
    generateMonthDays(DateTime.now().year, widget.date);
    getNumberOfWeeks(DateTime.now().year, widget.date);
  }

  @override
  Widget build(BuildContext context) {
    List<int> notAvailableDay = [
      1,
      8,
      15,
      22,
      29,
      3,
      10,
      17,
      24,
      5,
      12,
      19,
      26
    ];
    List<int> nonWorkDay = [
      16,
      11,
      27,
      4,
    ];
    DateTime now = DateTime.now();
    List<DateTime?> days = generateMonthDays(now.year, widget.date);

    return Container(
      // height: containerHeight,
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
          // Display weekdays as headers
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
                        style: AutilabTextStyle.medium14_500.copyWith(
                          color: day == 'Sun' ? Colors.red : AutilabColor.black,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          // Display calendar grid
          GridView.builder(
            shrinkWrap: true,
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
              bool isSelected = day != null && selectedDate == day;

              return GestureDetector(
                onTap: () {
                  if (!isSunday &&
                      day != null &&
                      !notAvailableDay.contains(day.day) &&
                      !nonWorkDay.contains(day.day)) {
                    widget.onTap(day);
                    setState(() {
                      selectedDate = day;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: (day != null && !isSunday)
                        ? (isSelected
                            ? AutilabColor.blue
                            : notAvailableDay.contains(day.day)
                                ? AutilabColor.lightGray
                                : (nonWorkDay.contains(day.day) &&
                                        widget.isSelect == true)
                                    ? const Color(0xffFBE4E4)
                                    : AutilabColor.bb)
                        : Colors.transparent,
                    borderRadius:
                        BorderRadius.circular(widget.isMobile ? 8 : 24),
                  ),
                  child: Center(
                    child: Text(
                      day != null ? DateFormat('d').format(day) : '',
                      style: AutilabTextStyle.small16_400.copyWith(
                        color: (day != null && !isSunday)
                            ? AutilabColor.black
                            : Colors.red,
                        fontSize: widget.isMobile ? 16 : 18,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
