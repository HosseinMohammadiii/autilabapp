import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/functions/animation_control.dart';

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
  List<String> images = [
    'assets/images/spech_therapy_image.svg',
    'assets/images/Occupational_Therapy_image.svg',
    'assets/images/family_support_image.svg',
  ];
  //Title list for pageView builder
  List<String> title = [
    'Speech Therapy',
    'Occupational Therapy',
    'Family Support',
  ];
  //Description list for pageView builder
  List<String> description = [
    'Assisting children who have difficulties in learning to speak and social communication.',
    'Enhancing motor skills and muscle coordination for children with autism.',
    'Supporting and educating parents to manage behaviors and stress related to autism.',
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
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 540,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SvgPicture.asset(images[index]),
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                title[index],
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  description[index],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
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
                            ],
                          );
                        },
                      ),
                    ),
                    CustomButtonWidget(
                      onTap: nextPage,
                      height: 50,
                      color: AutilabColor.bb,
                      text: 'Next',
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        context.goNamed(AutiLabRoutes.welcomeScreen);
                      },
                      height: 50,
                      width: 50,
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
    );
  }
}
