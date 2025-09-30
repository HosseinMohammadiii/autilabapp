import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/functions/animation_control.dart';
import '../widgets/tools_box_widget.dart';

class ToolsClass {
  final String title;
  final String description;
  final String titleButton;
  final String svg;
  ToolsClass(this.title, this.description, this.titleButton, this.svg);
}

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen>
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
  void didUpdateWidget(covariant ToolsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  List<ToolsClass> toolsItems = [
    ToolsClass(
      'Article',
      'Discover our insightful articles on autism that delves into the nuances of the spectrum',
      'Reading Articles',
      'assets/images/article_image.svg',
    ),
    // ToolsClass(
    //   'Communication Environment',
    //   'The environment for holding educational and therapeutic sessions for children',
    //   'Use Of The Environment',
    //   'assets/images/communication_image.svg',
    // ),
    ToolsClass(
      'Talent Identification Test',
      "Aptitude test to identify children's talents and improve their future",
      'Do The Test',
      'assets/images/talent_image.svg',
    ),
    ToolsClass(
      'Personality Screening Test',
      "Discover deeper insights into your unique personality with our autism-focused assessment",
      'Do The Test',
      'assets/images/personality_image.svg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile() {
          if (constraints.maxWidth < 600) {
            return true;
          } else {
            return false;
          }
        }

        return FadeTransition(
          opacity: animationHelper.fadeAnimation,
          child: Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: toolsItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: ToolsBoxWidget(
                          isMobile: isMobile(),
                          title: toolsItems[index].title,
                          description: toolsItems[index].description,
                          titleButton: toolsItems[index].titleButton,
                          svg: toolsItems[index].svg,
                          onTap: () async {
                            switch (index) {
                              case 0:
                                context
                                    .pushNamed(AutiLabRoutes.articleItemScreen);
                                break;
                              // case 1:
                              //   context.pushNamed(AutiLabRoutes.whiteBoardScreen);
                              //   break;
                              case 1:
                                context.pushNamed(
                                    AutiLabRoutes.aptitudeTestScreen,
                                    extra: {
                                      'image': 'assets/images/talent_image.svg',
                                      'title': 'Aptitude Test',
                                      'subTitle': 'Talent Identification Test',
                                      'description':
                                          "Discover your child's hidden potentials and help them grow endlessly.",
                                      'onTap': () {
                                        context.pushNamed(AutiLabRoutes
                                            .quizMultiSelectScreen);
                                      },
                                    });

                                break;
                              case 2:
                                context.pushNamed(
                                    AutiLabRoutes.aptitudeTestScreen,
                                    extra: {
                                      'image':
                                          'assets/images/personality_image.svg',
                                      'title': 'Personality Test',
                                      'subTitle': 'Personality Test',
                                      'description':
                                          "Discover your child's personality and help them find the right path in life.",
                                      'onTap': () {
                                        context.pushNamed(AutiLabRoutes
                                            .quizMultiSelectScreen);
                                      },
                                    });
                                break;
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
