import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/doctor_box_widget.dart';
import 'package:autilab_project/features/data/tool/widgets/article_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../doctor/widgets/nearby_card_widget.dart';
import '../../tool/page/article_item_screen.dart';

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

  bool isLike = true;

  List<ArticleContent> newArticleList = [
    ArticleContent(
      title:
          'Evaluating Changes in the Prevalence of the Autism Spectrum Disorders (ASDs)',
      description:
          'ASD diagnoses rising; causes unclear; experts seek better understanding.',
      file: 'assets/texts/article06.txt',
      image: 'assets/images/article/06.jpg',
    ),
    ArticleContent(
      title:
          'Adolescents With Autism Spectrum Disorder: Diagnostic Patterns, Co-occurring Conditions, and Transition Planning',
      description:
          'Delayed ASD diagnosis common; risks vary; ongoing mental health needs grow.',
      file: 'assets/texts/article07.txt',
      image: 'assets/images/article/07.jpg',
    ),
    ArticleContent(
      title:
          'Autism Spectrum Disorder Diagnoses and Congenital Cytomegalovirus',
      description: 'cCMV infection at birth linked to 2.5× higher autism risk.',
      file: 'assets/texts/article08.txt',
      image: 'assets/images/article/08.jpg',
    ),
    ArticleContent(
      title:
          'Child and family characteristics associated with verbal communication difficulties in adolescents with autism and other developmental disabilitiesChild and family characteristics associated with verbal communication difficulties in adolescents with autism and other developmental disabilities',
      description:
          'ASD teens face lasting speech challenges influenced by early skills and background.',
      file: 'assets/texts/article09.txt',
      image: 'assets/images/article/09.jpg',
    ),
    ArticleContent(
      title:
          'Prevalence and Early Identification of Autism Spectrum Disorder Among Children Aged 4 and 8 Years — Autism and Developmental Disabilities Monitoring Network, 16 Sites, United States, 2022',
      description:
          'ASD affects 1 in 31 US children with disparities; early diagnosis improving.',
      file: 'assets/texts/article10.txt',
      image: 'assets/images/article/10.jpg',
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
          child: DefaultTabController(
            animationDuration: const Duration(seconds: 1),
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                leadingWidth: double.infinity,
                leading: appBarWidget(
                  context: context,
                  title: 'My Favorite',
                  isIcon: true,
                  isMobile: isMobile(),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(isMobile() ? 70 : 120),
                  child: Container(
                    width: double.infinity,
                    color: AutilabColor.white,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: isMobile() ? 50 : 72,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AutilabColor.lightGray,
                        borderRadius:
                            BorderRadius.circular(isMobile() ? 16 : 24),
                      ),
                      child: TabBar(
                        labelStyle: AutilabTextStyle.small18_400.copyWith(
                          color: Colors.black,
                        ),
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(isMobile() ? 16 : 24),
                          color: AutilabColor.bb,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Text(
                            'Article',
                            style: AutilabTextStyle.small16_400.copyWith(
                              fontSize: isMobile() ? 16 : 24,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              'Doctor',
                              style: AutilabTextStyle.small16_400.copyWith(
                                fontSize: isMobile() ? 16 : 24,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              'Center',
                              style: AutilabTextStyle.small16_400.copyWith(
                                fontSize: isMobile() ? 16 : 24,
                              ),
                            ),
                          ),
                          // FittedBox(
                          //   child: Text(
                          //     'Post',
                          //     style: AutilabTextStyle.small16_400,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: AutilabMargin.marginFullScreen,
                        child: Column(
                          children: [
                            // const SizedBox(
                            //   height: 32,
                            // ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: newArticleList.length,
                              padding: const EdgeInsets.only(top: 32),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: ArticleBoxWidget(
                                    isMobile: isMobile(),
                                    isLike: true,
                                    image: newArticleList[index].image!,
                                    title: newArticleList[index].title,
                                    description:
                                        newArticleList[index].description,
                                    ontap: () {
                                      context.pushNamed(
                                          AutiLabRoutes.mainContentScreen,
                                          extra: {
                                            'articleImage':
                                                newArticleList[index].image,
                                            'articleText':
                                                newArticleList[index].file,
                                            'articleDescription':
                                                newArticleList[index]
                                                    .description,
                                            'articleTitle':
                                                newArticleList[index].title,
                                            'isLike': true,
                                          });
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 6,
                      padding: AutilabMargin.marginFullScreen.copyWith(top: 24),
                      itemBuilder: (context, index) {
                        return DoctorBoxWidget(
                          isMobile: isMobile(),
                          isLike: true,
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: 6,
                      padding: const EdgeInsets.only(top: 32),
                      itemBuilder: (context, index) {
                        return NearbyCardWidget(
                          isMobile: isMobile(),
                          isLike: true,
                        );
                      },
                    ),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   padding: AutilabMargin.marginFullScreen,
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     crossAxisSpacing: 12,
                    //     mainAxisSpacing: 20,
                    //   ),
                    //   itemCount: 9,
                    //   itemBuilder: (context, index) {
                    //     return ClipRRect(
                    //       borderRadius: BorderRadius.circular(8),
                    //       child: Image.asset(
                    //         'assets/images/child2_image.jpg',
                    //         fit: BoxFit.cover,
                    //       ),
                    //     );
                    //   },
                    // ),
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
