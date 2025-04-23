import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_tabbar_widget.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/home/widgets/article_box_widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen>
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
  void didUpdateWidget(covariant MyFavoriteScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  bool isLike = false;
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar:
            appBarWidget(context: context, title: 'My Favorite', isIcon: true),
        body: SafeArea(
          child: CustomTabBarWidget(
            tabLength: 4,
            tabBar: const [
              Text(
                'Article',
                style: AutilabTextStyle.small16_400,
              ),
              Text(
                'Doctor',
                style: AutilabTextStyle.small16_400,
              ),
              Text(
                'Center',
                style: AutilabTextStyle.small16_400,
              ),
              Text(
                'Post',
                style: AutilabTextStyle.small16_400,
              ),
            ],
            tabBarView: [
              SingleChildScrollView(
                child: Padding(
                  padding: AutilabMargin.marginFullScreen,
                  child: Column(
                    children: [
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
              const Text(
                'Doctor',
                style: AutilabTextStyle.small16_400,
              ),
              const Text(
                'Center',
                style: AutilabTextStyle.small16_400,
              ),
              const Text(
                'Post',
                style: AutilabTextStyle.small16_400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
