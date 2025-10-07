import 'package:autilab_project/features/data/doctor/presentation/page/make_appointment_screen.dart';
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
    this.availableDays = const [], // فقط این روزها قابل انتخاب هستن
  });

  final bool isMobile;
  final Function(DateTime? day, int id) onTap;
  final bool isSelect;
  final int date;
  final List<DayCalss> availableDays;

  @override
  State<CalendarGrid> createState() => _CalendarGridState();
}

class _CalendarGridState extends State<CalendarGrid> {
  DateTime? selectedDate;

  List<DateTime?> generateMonthDays(int year, int month) {
    List<DateTime?> days = [];

    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysInMonth = DateTime(year, month + 1, 0).day;

    int startWeekday = (firstDayOfMonth.weekday + 6) % 7;
    days.addAll(List.filled(startWeekday, null));

    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(year, month, i));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<DateTime?> days = generateMonthDays(now.year, widget.date);

    return Container(
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
            children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: AutilabTextStyle.medium14_500.copyWith(
                          color: day == 'Sun' ? Colors.red : AutilabColor.black,
                          fontSize: widget.isMobile ? 14 : 20,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 40,
              mainAxisSpacing: widget.isMobile ? 4 : 13,
              crossAxisSpacing: widget.isMobile ? 6 : 18,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              DateTime? day = days[index];
              if (day == null) return const SizedBox.shrink();

              bool isSunday =
                  day.weekday == DateTime.sunday; // 7 یا DateTime.sunday

              // پیدا کردن روز در availableDays
              DayCalss? availableDay = widget.availableDays.firstWhere(
                (d) => d.day == day.day,
                orElse: () => DayCalss(-1, -1),
              );

              bool isAvailable = availableDay.id != -1;

              // روز انتخاب‌شده
              bool isSelected = selectedDate != null &&
                  day.year == selectedDate!.year &&
                  day.month == selectedDate!.month &&
                  day.day == selectedDate!.day;

              // تعیین رنگ پس‌زمینه
              Color bgColor;
              if (isSunday) {
                bgColor = Colors.transparent; // یکشنبه‌ها بدون باکس
              } else {
                bgColor = isAvailable
                    ? (isSelected ? AutilabColor.blue : AutilabColor.bb)
                    : AutilabColor.lightGray;
              }

              // تعیین رنگ متن
              Color textColor;
              if (isSunday) {
                textColor = Colors.red;
              } else {
                textColor = isAvailable ? AutilabColor.black : Colors.grey;
              }

              return GestureDetector(
                onTap: isAvailable && !isSunday
                    ? () {
                        setState(() {
                          selectedDate = day;
                        });
                        widget.onTap(day, availableDay.id);
                      }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius:
                        BorderRadius.circular(widget.isMobile ? 8 : 24),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('d').format(day),
                      style: AutilabTextStyle.small16_400.copyWith(
                        color: textColor,
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
