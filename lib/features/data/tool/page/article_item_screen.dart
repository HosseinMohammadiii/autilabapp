import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../home/widgets/article_box_widget.dart';

class ArticleItemScreen extends StatefulWidget {
  const ArticleItemScreen({super.key});

  @override
  State<ArticleItemScreen> createState() => _ArticleItemScreenState();
}

class _ArticleItemScreenState extends State<ArticleItemScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ArticleItemScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: AutilabMargin.marginFullScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popular Article',
                    style: AutilabTextStyle.small20_400,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 292,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 338,
                          height: 100,
                          padding: const EdgeInsets.all(16),
                          margin: EdgeInsets.only(right: index == 2 ? 0 : 15),
                          decoration: BoxDecoration(
                            color: AutilabColor.white,
                            border: Border.all(color: AutilabColor.bb),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 8,
                            children: [
                              Image.asset(
                                'assets/images/kid_image.png',
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                'Gaming And Autism',
                                style: AutilabTextStyle.medium16_500,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Balancing Screen Time For Kids',
                                    style: AutilabTextStyle.small14_400,
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
                                          )
                                        : const Icon(
                                            Icons.favorite_border_rounded,
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Text(
                    'New Articles',
                    style: AutilabTextStyle.small20_400,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: ArticleBoxWidget(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
