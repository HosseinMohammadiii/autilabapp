import 'package:flutter/material.dart';

class BubbleBackgroundWidget extends StatelessWidget {
  const BubbleBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 47,
            height: 47,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xffE0E7FF),
            ),
          ),
        ),
        Container(
          width: 86,
          height: 86,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xffE0E7FF),
          ),
        ),
      ],
    );
  }
}
