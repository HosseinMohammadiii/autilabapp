import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';

class TalentResultLinerWidget extends StatelessWidget {
  const TalentResultLinerWidget({
    super.key,
    required this.gradient1,
    required this.gradient2,
    required this.activeLine,
  });
  final Color gradient1;
  final Color gradient2;
  final double activeLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17,
      decoration: BoxDecoration(
        color: const Color(0xffc0bdaa),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 28,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemBuilder: (context, index) {
              return Container(
                height: 4,
                width: 4,
                margin: const EdgeInsets.only(right: 14),
                decoration: const BoxDecoration(
                  color: Color(0xff454459),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: 17,
                width: (14 + 4) * (activeLine),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      gradient1,
                      gradient2,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AutilabColor.white, width: 0.5),
                ),
              ),
              Container(
                height: 6,
                width: 2,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  color: AutilabColor.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
