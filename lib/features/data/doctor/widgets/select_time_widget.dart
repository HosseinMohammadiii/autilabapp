import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart' show AutilabTextStyle;
import '../../../../utils/Lists/time_list.dart';

class SelectTimeWidget extends StatefulWidget {
  const SelectTimeWidget({
    super.key,
    required this.onTap,
    this.isSelect = true,
  });

  final Function(String? time) onTap;
  final bool? isSelect;

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  String selectedTime = '';

  @override
  Widget build(BuildContext context) {
    List<String> notAvailable = [
      '10:00 AM',
      '11:00 AM',
      '13:00 PM',
      '18:00 PM',
    ];
    return SliverGrid.builder(
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 40,
        crossAxisSpacing: 12,
        mainAxisSpacing: 6,
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
                      : AutilabColor.lightGray,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              timeAvailable[index],
              style: AutilabTextStyle.small14_400,
            ),
          ),
        );
      },
    );
  }
}
