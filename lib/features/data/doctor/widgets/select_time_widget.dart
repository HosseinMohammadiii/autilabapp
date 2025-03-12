import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../utils/Lists/time_list.dart';

class SelectTimeWidget extends StatefulWidget {
  const SelectTimeWidget({
    super.key,
    required this.onTap,
  });

  final Function(String? time) onTap;

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  String selectedTime = '';

  @override
  Widget build(BuildContext context) {
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
            if (time.isNotEmpty) {
              setState(() {
                selectedTime = time;
              });
              widget.onTap(time);
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AutilabColor.blue : AutilabColor.bb,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              timeAvailable[index],
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        );
      },
    );
  }
}
