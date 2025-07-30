import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/widgets/responsive_widget.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../../../utils/functions/cacheimahe_function.dart';

// ignore: must_be_immutable
class MainContentScreen extends StatefulWidget {
  MainContentScreen({
    super.key,
    required this.articleImage,
    required this.articleText,
    required this.articleTitle,
    required this.articleDescription,
    required this.isLike,
  });
  final String articleImage;
  final String articleText;
  final String articleTitle;
  final String articleDescription;
  bool? isLike;

  @override
  State<MainContentScreen> createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  late Future<String> _futureText;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));
    animationHelper.animationController.forward();
    _futureText = loadTextFileArticle(widget.articleText);
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  bool isLike = false;

  @override
  void didUpdateWidget(covariant MainContentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  Future<String> loadTextFileArticle(String textFile) async {
    var content = await rootBundle.loadString(textFile);
    return content;
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
              appBar: appBarWidget(
                context: context,
                title: 'Back',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: AutilabMargin.marginFullScreen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            height: isMobile() ? 170 : 270,
                            width: double.infinity,
                            child: Image.asset(
                              fit: BoxFit.fill,
                              widget.articleImage,
                              cacheWidth: cacheImageFunction(
                                  isMobile() ? 170 : 270, context),
                              cacheHeight: cacheImageFunction(
                                  isMobile() ? 170 : 270, context),
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                if (frame == null) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AutilabColor.bb,
                                    ),
                                  );
                                } else {
                                  return child;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          spacing: 4,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(85),
                              child: Image.asset(
                                'assets/images/doctor4.png',
                                width: isMobile() ? 16 : 24,
                                height: isMobile() ? 16 : 24,
                              ),
                            ),
                            Text(
                              'Dr.Masoomi',
                              style: AutilabTextStyle.small14_400.copyWith(
                                fontSize: isMobile() ? 14 : 18,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '2 Days Ago',
                              style: AutilabTextStyle.small12_400.copyWith(
                                  color: AutilabColor.gray,
                                  fontSize: isMobile() ? 12 : 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          widget.articleTitle,
                          textAlign: TextAlign.left,
                          style: AutilabTextStyle.medium20_500.copyWith(
                            fontSize: isMobile() ? 20 : 24,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          widget.articleDescription,
                          textAlign: TextAlign.left,
                          style: AutilabTextStyle.small16_400.copyWith(
                            fontSize: isMobile() ? 16 : 20,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        FutureBuilder(
                          future: _futureText,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                snapshot.data ?? '',
                                style: AutilabTextStyle.small14_400.copyWith(
                                  fontSize: isMobile() ? 14 : 20,
                                ),
                                textAlign: TextAlign.justify,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLike = !isLike;
                              widget.isLike = isLike;
                            });
                          },
                          child: Container(
                            height: isMobile() ? 40 : 53,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: AutilabColor.drawerWhite,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              spacing: 8,
                              children: [
                                LikeWidget(
                                  isMobile: isMobile(),
                                  borderColor: Colors.transparent,
                                  isLike: widget.isLike ?? false,
                                  onTap: () {},
                                ),
                                Text(
                                  'Add To Favorite',
                                  style: AutilabTextStyle.small12_400.copyWith(
                                    fontSize: isMobile() ? 12 : 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
