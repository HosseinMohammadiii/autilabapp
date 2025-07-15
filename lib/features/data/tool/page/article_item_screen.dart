import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../home/widgets/article_box_widget.dart';
import '../widgets/populararticle_widget.dart';

class ArticleContent {
  String title;
  String description;
  String file;
  String? image;
  ArticleContent({
    required this.title,
    required this.description,
    required this.file,
    this.image,
  });
}

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

  List<ArticleContent> popularArticleList = [
    ArticleContent(
      title: 'Autism Spectrum Disorder in 2023: Understanding the Challenge',
      description:
          'ASD: lifelong condition, unclear causes, early intervention improves outcomes.',
      file: 'assets/texts/article01.txt',
      image: 'assets/images/article/01.jpg',
    ),
    ArticleContent(
      title:
          'Persistence of Autism Spectrum Disorder From Early Childhood Through School Age',
      description:
          'Some early ASD diagnoses change; girls and higher skills predict change.',
      file: 'assets/texts/article02.txt',
      image: 'assets/images/article/02.jpg',
    ),
    ArticleContent(
      title: 'Gut Imbalances Might Play a Role in Autism, Study Finds',
      description:
          'Gut-brain link: autistic kids show altered tryptophan, brain activity.',
      file: 'assets/texts/article03.txt',
      image: 'assets/images/article/03.jpg',
    ),
    ArticleContent(
      title:
          'AI Could Help Identify Toddlers Who May Be Autistic, Researchers Say',
      description:
          'AI system flags autism risk in toddlers, but needs clinical backup.',
      file: 'assets/texts/article04.txt',
      image: 'assets/images/article/04.jpg',
    ),
    ArticleContent(
      title:
          'The Childhood Prevalence, Gender Ratio, and Characteristics of Autism Spectrum Disorder in Cyprus Using School Report: A Cross-Sectional Study',
      description:
          'ASD in Cyprus: 1.8% rate, mostly boys, common ADHD comorbidity.',
      file: 'assets/texts/article05.txt',
      image: 'assets/images/article/05.jpg',
    ),
  ];

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
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(context: context, title: 'Article', isIcon: true),
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
                      itemCount: popularArticleList.length,
                      padEnds: false,
                      pageSnapping: false,
                      controller: PageController(viewportFraction: 0.9),
                      itemBuilder: (context, index) {
                        return PopularArticleWidget(
                          index: index,
                          image: popularArticleList[index].image!,
                          title: popularArticleList[index].title,
                          description: popularArticleList[index].description,
                          isLike: false,
                          ontap: () {
                            context.pushNamed(AutiLabRoutes.mainContentScreen,
                                extra: {
                                  'articleImage':
                                      popularArticleList[index].image,
                                  'articleText': popularArticleList[index].file,
                                  'articleDescription':
                                      popularArticleList[index].description,
                                  'articleTitle':
                                      popularArticleList[index].title,
                                });
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
                    itemCount: newArticleList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ArticleBoxWidget(
                          isLike: false,
                          image: newArticleList[index].image!,
                          title: newArticleList[index].title,
                          description: newArticleList[index].description,
                          ontap: () {
                            context.pushNamed(AutiLabRoutes.mainContentScreen,
                                extra: {
                                  'articleImage': newArticleList[index].image,
                                  'articleText': newArticleList[index].file,
                                  'articleDescription':
                                      newArticleList[index].description,
                                  'articleTitle': newArticleList[index].title,
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
        ),
      ),
    );
  }
}
