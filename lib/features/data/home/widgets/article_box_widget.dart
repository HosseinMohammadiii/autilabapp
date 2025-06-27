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
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Flexible(
            child: SizedBox(
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/game_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                const Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        'Gaming And Autism',
                        style: AutilabTextStyle.medium16_500,
                      ),
                    ),
                    Text(
                      'Balancing Screen Time For Kids',
                      style: AutilabTextStyle.small14_400,
                    ),
                  ],
                ),
                FittedBox(
                  child: Row(
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
                      const SizedBox(
                        width: 20,
                      ),
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
                                size: 12,
                              )
                            : const Icon(
                                Icons.favorite_border_rounded,
                                size: 18,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
