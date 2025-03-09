import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({
    super.key,
    required this.onTap,
  });

  final Function() onTap;
  // Generate a list of days for a given month, including empty slots for alignment
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
                // Check if the day is Sunday
                bool isSunday = day != null && day.weekday == 6;
                return GestureDetector(
                  onTap: onTap,
                  child: Container(
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
