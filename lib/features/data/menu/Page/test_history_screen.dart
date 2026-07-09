import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/loading_indicator_widget.dart';
import 'package:autilab_project/common/widgets/test_result_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/core/network/locator.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_bloc.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_event.dart';
import 'package:autilab_project/features/data/test/presentation/bloc/test_bloc.dart';
import 'package:autilab_project/features/data/test/presentation/bloc/test_event.dart';
import 'package:autilab_project/features/data/test/presentation/bloc/test_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/responsive_widget.dart';
import '../../../../presentation/screens/not_connection_screen.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../doctor/presentation/page/nearby_center_details_screen.dart'
    show TitleAndIconWidget;
import '../../home/data/model/intelligence_test_model.dart';
import '../../home/presentation/bloc/home_state.dart';

class TalentTest {
  Color color;
  String title;
  String percentage;

  TalentTest(this.color, this.title, this.percentage);
}

class TestHistoryScreen extends StatefulWidget {
  const TestHistoryScreen({
    super.key,
    required this.initialIndexPage,
  });
  final int initialIndexPage;

  @override
  State<TestHistoryScreen> createState() => _TestHistoryScreenState();
}

class _TestHistoryScreenState extends State<TestHistoryScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  bool isScroll = false;

  int totalScore = 0;

  // List<IntelligenceTestModel> intelligenceTestList = [];

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
            // child: BlocProvider(
            //   create: (context) =>
            //       HomeBloc(locator.get())..add(DisplayHomeContent()),
            child:
                BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
              // if (state is HomeFetchData) {
              //   state.homeResponse.fold(
              //     (l) {},
              //     (response) {
              //       for (var element in response) {
              //         intelligenceTestList = element.intelligenceTestModel;
              //       }
              //     },
              //   );
              // }
            }, builder: (context, state) {
              // if (state is HomeLoading) {
              //   return const LoadingProgressWidget();
              // }
              // if (state is HomeErrorHandling) {
              //   return NotConnectionInternetScreen(
              //     onChange: () async {
              //       context.read<HomeBloc>().add(DisplayHomeContent());
              //     },
              //   );
              // }
              // if (state is HomeFetchData) {
              return DefaultTabController(
                animationDuration: const Duration(seconds: 1),
                length: 2,
                initialIndex: widget.initialIndexPage,
                child: Scaffold(
                  appBar: AppBar(
                    leading: appBarWidget(
                      context: context,
                      title: 'Test History',
                      isIcon: true,
                      isMobile: isMobile(),
                    ),
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
                            tabs: [
                              Visibility(
                                visible: isMobile(),
                                replacement: const Text(
                                  'Talent Test',
                                  style: AutilabTextStyle.small24_400,
                                ),
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Talent Test',
                                    style: AutilabTextStyle.small16_400,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isMobile(),
                                replacement: const Text(
                                  'Personality Test',
                                  style: AutilabTextStyle.small24_400,
                                ),
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Personality Test',
                                    style: AutilabTextStyle.small16_400,
                                  ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 48,
                                        ),
                                        TitleAndIconWidget(
                                          isMobile: isMobile(),
                                          icon: 'assets/icons/info-circle.svg',
                                          title: 'Talent Assessment Report',
                                        ),
                                        const SizedBox(
                                          height: 26,
                                        ),
                                        Text(
                                          'Based on the results of the multi-dimensional talent assessment, this child has shown strong potential in several key areas.',
                                          style: AutilabTextStyle.small16_400
                                              .copyWith(
                                            fontSize: isMobile() ? 16 : 24,
                                          ),
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
                                    TitleAndIconWidget(
                                      isMobile: isMobile(),
                                      icon: 'assets/icons/note.svg',
                                      title: 'Talent Test Chart',
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    TestResultWidget(
                                      isShowTitle: false,
                                      isMobile: isMobile(),
                                      intelligenceData: intelligenceTestList,
                                    ),
                                    CustomButtonWidget(
                                      isMobile: isMobile(),
                                      onTap: () {
                                        context.pushNamed(
                                            AutiLabRoutes.typeTestsScreen);
                                      },
                                      height: 50,
                                      margin: const EdgeInsets.only(
                                          bottom: 18, top: 48),
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
                        // BlocProvider(
                        //   create: (context) => TestBloc(locator.get())
                        //     ..add(DisplayAutismTestResult()),
                        //   child:

                        BlocBuilder<TestBloc, TestState>(
                            builder: (context, state) {
                          // if (state is TestLoading) {
                          //   return const LoadingProgressWidget();
                          // }
                          // if (state is TestError) {
                          //   if (state.errorMessage.statusCode == 404) {
                          //     return Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         SvgPicture.asset(
                          //           'assets/icons/item_notfound.svg',
                          //           width: isMobile() ? 160 : 240,
                          //           height: isMobile() ? 160 : 240,
                          //         ),
                          //         Text(
                          //           'Item Not Found',
                          //           style: AutilabTextStyle.medium20_500
                          //               .copyWith(
                          //             fontSize: isMobile() ? 20 : 32,
                          //           ),
                          //         ),
                          //         CustomButtonWidget(
                          //           isMobile: isMobile(),
                          //           onTap: () {
                          //             context.pushNamed(
                          //                 AutiLabRoutes.typeTestsScreen);
                          //           },
                          //           height: 50,
                          //           margin: const EdgeInsets.only(
                          //               bottom: 48,
                          //               top: 48,
                          //               right: 20,
                          //               left: 20),
                          //           color: AutilabColor.bb,
                          //           text: 'Take Test',
                          //           textStyle: AutilabTextStyle.small18_400,
                          //         ),
                          //       ],
                          //     );
                          //   } else {
                          //     return NotConnectionInternetScreen(
                          //       onChange: () async {
                          //         context
                          //             .read<TestBloc>()
                          //             .add(DisplayAutismTestResult());
                          //       },
                          //     );
                          //   }
                          // }
                          // if (state is DisplayAutismTestResultState) {
                          //   for (var element
                          //       in state.displayAutismTestResult) {
                          //     totalScore = element.totalscore;
                          //   }
                          return Scaffold(
                            bottomNavigationBar: CustomButtonWidget(
                              isMobile: isMobile(),
                              onTap: () {
                                context
                                    .pushNamed(AutiLabRoutes.typeTestsScreen);
                              },
                              height: 50,
                              // margin:
                              //     const EdgeInsets.only(bottom: 48, top: 48),
                              color: AutilabColor.bb,
                              text: 'Take Test Again',
                              textStyle: AutilabTextStyle.small18_400,
                            ),
                            body: CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: AutilabMargin.marginFullScreen,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const SizedBox(
                                          height: 48,
                                        ),
                                        TitleAndIconWidget(
                                          isMobile: isMobile(),
                                          icon: 'assets/icons/info-circle.svg',
                                          title: 'Personality Test Report',
                                        ),

                                        // _readeMoreButtonWidget(context),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        autismTestDiscription(15, isMobile()),
                                        // TitleAndIconWidget(
                                        //   isMobile: isMobile(),
                                        //   icon: 'assets/icons/note.svg',
                                        //   title: 'Personality Test Chart',
                                        // ),
                                        // const SizedBox(
                                        //   height: 24,
                                        // ),
                                        // Container(
                                        //   padding: const EdgeInsets.all(16),
                                        //   decoration: BoxDecoration(
                                        //     color: const Color(0xffECF0FF),
                                        //     border:
                                        //         Border.all(color: AutilabColor.bb),
                                        //     borderRadius: BorderRadius.circular(24),
                                        //   ),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       ListView.builder(
                                        //         shrinkWrap: true,
                                        //         physics:
                                        //             const NeverScrollableScrollPhysics(),
                                        //         itemCount: talentTestItem.length,
                                        //         padding: EdgeInsets.symmetric(
                                        //             vertical: isMobile() ? 8 : 16,
                                        //             horizontal: isMobile() ? 8 : 16),
                                        //         itemBuilder: (context, index) {
                                        //           return Column(
                                        //             children: [
                                        //               Row(
                                        //                 crossAxisAlignment:
                                        //                     CrossAxisAlignment.start,
                                        //                 spacing: 8,
                                        //                 children: [
                                        //                   Container(
                                        //                     width:
                                        //                         isMobile() ? 24 : 40,
                                        //                     height:
                                        //                         isMobile() ? 24 : 40,
                                        //                     decoration: BoxDecoration(
                                        //                       shape: BoxShape.circle,
                                        //                       color: talentTestItem[
                                        //                               index]
                                        //                           .color,
                                        //                     ),
                                        //                   ),
                                        //                   Text(
                                        //                     talentTestItem[index]
                                        //                         .title,
                                        //                     style: AutilabTextStyle
                                        //                         .small16_400
                                        //                         .copyWith(
                                        //                       fontSize: isMobile()
                                        //                           ? 16
                                        //                           : 20,
                                        //                     ),
                                        //                     textAlign:
                                        //                         TextAlign.justify,
                                        //                   ),
                                        //                   const Spacer(),
                                        //                   Container(
                                        //                     height:
                                        //                         isMobile() ? 24 : 40,
                                        //                     width:
                                        //                         isMobile() ? 60 : 120,
                                        //                     alignment:
                                        //                         Alignment.center,
                                        //                     decoration: BoxDecoration(
                                        //                       color: AutilabColor.bb,
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(8),
                                        //                     ),
                                        //                     child: Text(
                                        //                       talentTestItem[index]
                                        //                           .percentage,
                                        //                       style: AutilabTextStyle
                                        //                           .small14_400
                                        //                           .copyWith(
                                        //                         fontSize: isMobile()
                                        //                             ? 14
                                        //                             : 20,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               if (index <
                                        //                   talentTestItem.length - 1)
                                        //                 Padding(
                                        //                   padding: EdgeInsets.symmetric(
                                        //                       vertical: index ==
                                        //                               talentTestItem
                                        //                                       .length -
                                        //                                   1
                                        //                           ? 0
                                        //                           : 12),
                                        //                   child: const Divider(
                                        //                     thickness: 0.5,
                                        //                     color: AutilabColor.bb,
                                        //                   ),
                                        //                 ),
                                        //             ],
                                        //           );
                                        //         },
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                            // return const SizedBox();
                            // },
                            ),
                        // ),
                        // ],
                      ],
                    ),
                  ),
                ),
              );
            }
                    // return const SizedBox();
                    // },
                    ),
          ),
        );
        // );
      },
    );
  }

//Widget for dislay autism test description
  Widget autismTestDiscription(int percentage, bool isMobile) {
    String title = '';
    String description = '';
    Color color = AutilabColor.blue;

    //Set the title based on the percentage range
    switch (percentage) {
      case >= 0 && <= 20:
        title = '$percentage% Low Risk';
        break;
      case >= 21 && <= 50:
        title = '$percentage% Medium Risk';
        break;
      case >= 51 && <= 100:
        title = '$percentage% High Risk';
        break;
      default:
        title = '$percentage% Low Risk';
        break;
    }

    //Set the description text based on the percentage range
    switch (percentage) {
      case >= 0 && <= 20:
        description =
            'Based on your responses, the AI assessment indicates a low likelihood of autism, estimated at 0–20%. This suggests that your child is generally developing within typical ranges. It is recommended to monitor developmental milestones and consider a re-assessment in 6–12 months. Please note that this is an estimate, and a small margin of error exists.';
        break;
      case >= 21 && <= 50:
        description =
            'The AI assessment indicates a moderate likelihood of autism, estimated at 21–50%. This suggests some traits may require closer observation. We recommend scheduling an online consultation with a qualified child psychiatrist or pediatric specialist for further evaluation. Regular monitoring and targeted support strategies may be beneficial. This result is an estimate and carries a margin of error.';
        break;
      case >= 51 && <= 100:
        description =
            'The AI assessment indicates a high likelihood of autism, estimated at 51–100%. This suggests that your child may benefit from immediate professional evaluation and personalized intervention strategies. We recommend consulting with a specialist in person to develop a comprehensive care plan. Please remember that this is an estimate and not a definitive diagnosis; some level of error is possible.';
        break;
      default:
        description =
            'Based on your responses, the AI assessment indicates a low likelihood of autism, estimated at 0–20%. This suggests that your child is generally developing within typical ranges. It is recommended to monitor developmental milestones and consider a re-assessment in 6–12 months. Please note that this is an estimate, and a small margin of error exists.';
        break;
    }

    //Set the color of the title container based on the percentage range
    switch (percentage) {
      case >= 0 && <= 20:
        color = AutilabColor.bb;
        break;
      case >= 21 && <= 50:
        color = AutilabColor.yellow2;
        break;
      case >= 51 && <= 100:
        color = AutilabColor.red;
        break;
      default:
        color = AutilabColor.blue;
        break;
    }

    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: AutilabTextStyle.medium18_500.copyWith(
              fontSize: isMobile ? 18 : 28,
              color: AutilabColor.white,
            ),
          ),
        ),
        Text(
          description,
          style: AutilabTextStyle.small16_400.copyWith(
            fontSize: isMobile ? 16 : 24,
          ),
        ),
      ],
    );
  }

//Read More Button Widget
  // Widget _readeMoreButtonWidget(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.centerRight,
  //     child: GestureDetector(
  //       onTap: () {
  //         context.pushNamed(AutiLabRoutes.testDescriptionScreen, extra: {
  //           'description':
  //               'Based on the results of the multi-dimensional talent assessment, this child has shown strong potential in several key areas.',
  //         });
  //       },
  //       child: Container(
  //         width: 120,
  //         height: 40,
  //         margin: const EdgeInsets.only(top: 12),
  //         padding: const EdgeInsets.symmetric(horizontal: 2),
  //         alignment: Alignment.center,
  //         decoration: BoxDecoration(
  //           color: AutilabColor.bb,
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         child: FittedBox(
  //           child: Row(
  //             spacing: 4,
  //             children: [
  //               Text(
  //                 'Read More',
  //                 style: AutilabTextStyle.small14_400,
  //               ),
  //               SvgPicture.asset(
  //                 'assets/icons/arrow-right.svg',
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
