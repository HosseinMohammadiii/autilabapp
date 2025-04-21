import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class ArticleBoxWidget extends StatefulWidget {
  const ArticleBoxWidget({super.key});

  @override
  State<ArticleBoxWidget> createState() => _ArticleBoxWidgetState();
}

class _ArticleBoxWidgetState extends State<ArticleBoxWidget> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AutilabColor.bb),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/game_image.png'),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gaming And Autism',
                  style: AutilabTextStyle.medium16_500,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Balancing Screen Time For Kids',
                  style: AutilabTextStyle.small14_400,
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(85),
                      child: Image.asset(
                        'assets/images/doctor3.png',
                        width: 16,
                        height: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'Dr.Masoomi',
                      style: AutilabTextStyle.small12_400,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLike = !isLike;
                        });
                      },
                      child: isLike
                          ? const Icon(
                              Icons.favorite_rounded,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border_rounded,
                            ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
