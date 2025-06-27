import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../home/widgets/article_box_widget.dart';
import '../widgets/populararticle_widget.dart';

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
                    height: 260,
                    child: PageView.builder(
                      itemCount: 3,
                      padEnds: false,
                      pageSnapping: false,
                      controller: PageController(viewportFraction: 0.9),
                      itemBuilder: (context, index) {
                        return PopularArticleWidget(
                          index: index,
                          ontap: () {
                            context.pushNamed(AutiLabRoutes.mainContentScreen);
                          },
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            context.pushNamed(AutiLabRoutes.mainContentScreen);
                          },
                          child: const ArticleBoxWidget(),
                        ),
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
