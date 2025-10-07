import 'package:flutter/material.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart' show AutilabTextStyle;
import 'package:autilab_project/features/data/doctor/presentation/page/make_appointment_screen.dart';

class SelectTimeWidget extends StatefulWidget {
  const SelectTimeWidget({
    super.key,
    required this.onTap,
    this.isSelect = true,
    this.backgroundColor,
    this.isMobile = true,
    this.timeWorkScheduel,
  });

  final bool isMobile;
  final Function(String? time) onTap;
  final bool? isSelect;
  final Color? backgroundColor;
  final TimeWorkScheduel? timeWorkScheduel;

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  String selectedTime = '';
  List<String> slots = [];

  @override
  void initState() {
    super.initState();
    _generateTimeSlotsOnce();
  }

  void _generateTimeSlotsOnce() {
    if (widget.timeWorkScheduel == null) return;

    final startTime = widget.timeWorkScheduel!.startTime;
    final endTime = widget.timeWorkScheduel!.endTime;
    final slotDuration = widget.timeWorkScheduel!.slotDuration;

    if (startTime.isNotEmpty && endTime.isNotEmpty && slotDuration > 0) {
      slots = generateTimeSlots(startTime, endTime, slotDuration);
    }
  }

  List<String> generateTimeSlots(
      String startTime, String endTime, int intervalMinutes) {
    DateTime now = DateTime.now();

    String fixTime(String t) {
      if (t.contains("AM") || t.contains("PM")) {
        final time = TimeOfDay.fromDateTime(
            DateTime.parse("2020-01-01 ${t.replaceAll(" ", "")}"));
        return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00";
      }
      return t.length == 5 ? "$t:00" : t;
    }

    final startStr = fixTime(startTime);
    final endStr = fixTime(endTime);

    DateTime start =
        DateTime.parse("${now.toIso8601String().split('T').first} $startStr");
    DateTime end =
        DateTime.parse("${now.toIso8601String().split('T').first} $endStr");

    if (end.isBefore(start)) {
      end = end.add(const Duration(days: 1));
    }

    List<String> slots = [];
    DateTime current = start;

    while (current.isBefore(end)) {
      slots.add(
          "${current.hour.toString().padLeft(2, '0')}:${current.minute.toString().padLeft(2, '0')}");
      current = current.add(Duration(minutes: intervalMinutes));
    }

    return slots;
  }

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox(),
      );
    }

    return SliverGrid.builder(
      itemCount: slots.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 40,
        mainAxisSpacing: 8,
        crossAxisSpacing: widget.isMobile ? 10 : 38,
      ),
      itemBuilder: (context, index) {
        final time = slots[index];
        final isSelected = selectedTime == time;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTime = time;
            });
            widget.onTap(time);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? AutilabColor.blue
                  : widget.backgroundColor ?? AutilabColor.backgroundDrawer,
              borderRadius: BorderRadius.circular(widget.isMobile ? 8 : 24),
            ),
            child: Text(
              time,
              style: AutilabTextStyle.small14_400.copyWith(
                fontSize: widget.isMobile ? 14 : 18,
                color: isSelected
                    ? AutilabColor.backgroundDrawer
                    : AutilabColor.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
