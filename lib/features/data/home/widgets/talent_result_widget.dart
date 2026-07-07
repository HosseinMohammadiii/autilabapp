import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';

class TalentResultWidget extends StatelessWidget {
  const TalentResultWidget({
    super.key,
    required this.title,
    required this.gradient1,
    required this.gradient2,
    required this.score,
    required this.textStyle,
  });
  final String title;
  final TextStyle textStyle;
  final Color gradient1;
  final Color gradient2;

  final double score;

  @override
  Widget build(BuildContext context) {
    int filledFlex = ((score / 100) * 15).round().clamp(0, 15);
    int emptyFlex = (15 - filledFlex).clamp(0, 15);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyle,
              ),
              const SizedBox(height: 12),
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xffc0bdaa),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: filledFlex == 0 ? 1 : filledFlex,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  gradient1,
                                  gradient2,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 6,
                              width: 2,
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: AutilabColor.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: emptyFlex,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          emptyFlex,
                          (index) => Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                              color: Color(0xff454459),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
