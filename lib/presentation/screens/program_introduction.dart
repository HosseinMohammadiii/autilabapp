import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../common/widgets/responsive_widget.dart';
import '../../utils/functions/animation_control.dart';

class ProgramIntroduction {
  String image;
  String title;
  String description;
  ProgramIntroduction(
      {required this.image, required this.title, required this.description});
}

class ProgramIntroductionScreen extends StatefulWidget {
  const ProgramIntroductionScreen({super.key});

  @override
  State<ProgramIntroductionScreen> createState() =>
      _ProgramIntroductionScreenState();
}

class _ProgramIntroductionScreenState extends State<ProgramIntroductionScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final pageController = PageController();
  //Image list for pageView builder
  List<ProgramIntroduction> programIntroductionList = [
    ProgramIntroduction(
      image: 'assets/images/spech_therapy_image.svg',
      title: 'Speech Therapy',
      description:
          'Assisting children who have difficulties in learning to speak and social communication.',
    ),
    ProgramIntroduction(
      image: 'assets/images/Occupational_Therapy_image.svg',
      title: 'Occupational Therapy',
      description:
          'Enhancing motor skills and muscle coordination for children with autism.',
    ),
    ProgramIntroduction(
      image: 'assets/images/family_support_image.svg',
      title: 'Family Support',
      description:
          'Supporting and educating parents to manage behaviors and stress related to autism.',
    ),
  ];

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

//Method for control and animate to next page pageView builder
  void nextPage() {
    if (pageController.page != 2) {
      pageController.animateToPage(
        pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.goNamed(AutiLabRoutes.welcomeScreen);
    }
  }

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

        return ResponsiveLayout(
          child: FadeTransition(
            opacity: animationHelper.fadeAnimation,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size(0, 20),
                child: AppBar(),
              ),
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      fillOverscroll: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: isMobile() ? 480 : 762,
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: AutilabMargin.marginFullScreen,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: SvgPicture.asset(
                                          programIntroductionList[index].image,
                                          width: isMobile() ? 350 : 550,
                                          height: isMobile() ? 350 : 550,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.03,
                                    ),
                                    Text(
                                      programIntroductionList[index].title,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: isMobile() ? 20 : 40,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.02,
                                    ),
                                    Padding(
                                      padding: AutilabMargin.marginFullScreen,
                                      child: Text(
                                        programIntroductionList[index]
                                            .description,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: isMobile() ? 16 : 32,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          SmoothPageIndicator(
                            controller: pageController,
                            count: 3,
                            effect: const ExpandingDotsEffect(
                              expansionFactor: 5,
                              dotHeight: 8,
                              dotWidth: 8,
                              dotColor: AutilabColor.bb,
                              activeDotColor: AutilabColor.blue,
                            ),
                          ),
                          CustomButtonWidget(
                            onTap: nextPage,
                            isMobile: isMobile(),
                            height: 50,
                            borderRadius: 16,
                            color: AutilabColor.bb,
                            text: 'Next',
                            margin: EdgeInsets.only(
                              right: 20,
                              left: 20,
                              top: 30,
                            ),
                            textStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          CustomButtonWidget(
                            isMobile: isMobile(),
                            onTap: () {
                              context.goNamed(AutiLabRoutes.welcomeScreen);
                            },
                            height: MediaQuery.sizeOf(context).height * 0.037,
                            width: 45,
                            color: AutilabColor.white,
                            text: 'skip',
                            textStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
