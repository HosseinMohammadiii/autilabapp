import 'package:flutter/material.dart';

class BubbleBackgroundWidget extends StatelessWidget {
  const BubbleBackgroundWidget({
    super.key,
    this.isMobile = true,
  });
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: isMobile ? 47 : 137,
            height: isMobile ? 47 : 137,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xffE0E7FF),
            ),
          ),
        ),
        Container(
          width: isMobile ? 86 : 171,
          height: isMobile ? 86 : 171,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xffE0E7FF),
          ),
        ),
      ],
    );
  }
}
