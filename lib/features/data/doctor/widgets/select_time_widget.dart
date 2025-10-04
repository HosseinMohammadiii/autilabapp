import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart' show AutilabTextStyle;
import '../../../../utils/Lists/time_date_list.dart';

class SelectTimeWidget extends StatefulWidget {
  const SelectTimeWidget({
    super.key,
    required this.onTap,
    this.isSelect = true,
    this.backgroundColor,
    this.isMobile = true,
  });
  final bool isMobile;
  final Function(String? time) onTap;
  final bool? isSelect;
  final Color? backgroundColor;

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  String selectedTime = '';

  @override
  Widget build(BuildContext context) {
    List<String> notAvailable = [
      '14:00 PM',
      '14:30 PM',
      '15:00 PM',
    ];
    return SliverGrid.builder(
      itemCount: timeAvailable.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 40,
        mainAxisSpacing: 8,
        crossAxisSpacing: widget.isMobile ? 10 : 38,
      ),
      itemBuilder: (context, index) {
        String time = timeAvailable[index];
        bool isSelected = selectedTime == time;

        return GestureDetector(
          onTap: () {
            if (time.isNotEmpty &&
                widget.isSelect == true &&
                notAvailable.contains(timeAvailable[index])) {
              setState(() {
                selectedTime = time;
              });
              widget.onTap(time);
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? AutilabColor.blue
                  : (notAvailable.contains(timeAvailable[index]))
                      ? AutilabColor.bb
                      : widget.backgroundColor ?? const Color(0xffFBE4E4),
              borderRadius: BorderRadius.circular(widget.isMobile ? 8 : 24),
            ),
            child: Text(
              timeAvailable[index],
              style: AutilabTextStyle.small14_400.copyWith(
                fontSize: widget.isMobile ? 14 : 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
