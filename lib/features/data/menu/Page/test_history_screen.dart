import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/test_result_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/functions/animation_control.dart';
import '../../doctor/page/nearby_center_details_screen.dart'
    show TitleAndIconWidget;

class TalentTest {
  Color color;
  String title;
  String percentage;

  TalentTest(this.color, this.title, this.percentage);
}

class TestHistoryScreen extends StatefulWidget {
  const TestHistoryScreen({super.key});

  @override
  State<TestHistoryScreen> createState() => _TestHistoryScreenState();
}

class _TestHistoryScreenState extends State<TestHistoryScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  bool isScroll = false;

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
  void didUpdateWidget(covariant TestHistoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  List<TalentTest> talentTestItem = [
    TalentTest(const Color(0xffDADB88), 'Introversion', '%30'),
    TalentTest(const Color(0xffAFDB88), 'Intuition', '%50'),
    TalentTest(const Color(0xff88A4DB), 'Feeling', '%60'),
    TalentTest(const Color(0xff88DBD5), 'Perceiving', '%50'),
    TalentTest(const Color(0xffDB88D5), 'Sociability', '%30'),
    TalentTest(const Color(0xffE5898A), 'Creativity', '%20'),
    TalentTest(const Color(0xff9E9E47), 'Self-confidence', '%90'),
    TalentTest(const Color(0xffBB52BD), 'Anxiety Level', '%70'),
    TalentTest(const Color(0xffE5981C), 'Perseverance & Focus', '%60'),
  ];
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: DefaultTabController(
        animationDuration: const Duration(seconds: 1),
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: appBarWidget(
                context: context, title: 'Test History', isIcon: true),
            leadingWidth: double.infinity,
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Container(
                width: double.infinity,
                color: AutilabColor.white,
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AutilabColor.lightGray,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TabBar(
                    labelStyle: AutilabTextStyle.small18_400.copyWith(
                      color: Colors.black,
                    ),
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AutilabColor.bb,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      FittedBox(
                        child: Text(
                          'Talent Test',
                          style: AutilabTextStyle.small16_400,
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          'Personality Test',
                          style: AutilabTextStyle.small16_400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: AutilabMargin.marginFullScreen,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 48,
                                ),
                                TitleAndIconWidget(
                                  icon: 'assets/icons/info-circle.svg',
                                  title: 'Talent Assessment Report',
                                ),
                                SizedBox(
                                  height: 26,
                                ),
                                Text(
                                  'Based on the results of the multi-dimensional talent assessment, this child has shown strong potential in several key areas.',
                                  style: AutilabTextStyle.small16_400,
                                  textAlign: TextAlign.left,
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // _readeMoreButtonWidget(context),
                              ],
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                            const TitleAndIconWidget(
                              icon: 'assets/icons/note.svg',
                              title: 'Talent Test Chart',
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const TestResultWidget(
                              isShowTitle: false,
                            ),
                            CustomButtonWidget(
                              onTap: () {
                                context
                                    .pushNamed(AutiLabRoutes.typeTestsScreen);
                              },
                              height: 50,
                              margin:
                                  const EdgeInsets.only(bottom: 18, top: 48),
                              color: AutilabColor.bb,
                              text: 'Take Test Again',
                              textStyle: AutilabTextStyle.small18_400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: AutilabMargin.marginFullScreen,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              height: 48,
                            ),
                            const TitleAndIconWidget(
                              icon: 'assets/icons/info-circle.svg',
                              title: 'Personality Test Report',
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              'Based on the completed personality assessment, this child exhibits a well-defined set of  personality traits that influence their behaviorl',
                              style: AutilabTextStyle.small16_400,
                              maxLines: 10,
                              textAlign: TextAlign.left,
                            ),
                            // _readeMoreButtonWidget(context),
                            const SizedBox(
                              height: 48,
                            ),
                            const TitleAndIconWidget(
                              icon: 'assets/icons/note.svg',
                              title: 'Personality Test Chart',
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xffECF0FF),
                                border: Border.all(color: AutilabColor.bb),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: talentTestItem.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            spacing: 8,
                                            children: [
                                              Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: talentTestItem[index]
                                                      .color,
                                                ),
                                              ),
                                              Text(
                                                talentTestItem[index].title,
                                                style: AutilabTextStyle
                                                    .small16_400,
                                                textAlign: TextAlign.justify,
                                              ),
                                              const Spacer(),
                                              Container(
                                                height: 24,
                                                width: 60,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AutilabColor.bb,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  talentTestItem[index]
                                                      .percentage,
                                                  style: AutilabTextStyle
                                                      .small14_400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (index < talentTestItem.length - 1)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: index ==
                                                          talentTestItem
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : 16),
                                              child: const Divider(
                                                thickness: 0.5,
                                                color: AutilabColor.bb,
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            CustomButtonWidget(
                              onTap: () {
                                context
                                    .pushNamed(AutiLabRoutes.typeTestsScreen);
                              },
                              height: 50,
                              margin:
                                  const EdgeInsets.only(bottom: 48, top: 48),
                              color: AutilabColor.bb,
                              text: 'Take Test Again',
                              textStyle: AutilabTextStyle.small18_400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Read More Button Widget
  Widget _readeMoreButtonWidget(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          context.pushNamed(AutiLabRoutes.testDescriptionScreen, extra: {
            'description':
                'Based on the results of the multi-dimensional talent assessment, this child has shown strong potential in several key areas.',
          });
        },
        child: Container(
          width: 120,
          height: 40,
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.symmetric(horizontal: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AutilabColor.bb,
            borderRadius: BorderRadius.circular(16),
          ),
          child: FittedBox(
            child: Row(
              spacing: 4,
              children: [
                const Text(
                  'Read More',
                  style: AutilabTextStyle.small14_400,
                ),
                SvgPicture.asset(
                  'assets/icons/arrow-right.svg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
