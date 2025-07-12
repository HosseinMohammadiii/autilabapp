import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/functions/animation_control.dart';

class MainContentScreen extends StatefulWidget {
  const MainContentScreen({
    super.key,
    required this.articleImage,
    required this.articleText,
    required this.articleTitle,
    required this.articleDescription,
  });
  final String articleImage;
  final String articleText;
  final String articleTitle;
  final String articleDescription;

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
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(context: context, title: 'Back', isIcon: true),
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
                      height: 170,
                      width: double.infinity,
                      child: Image.asset(
                        widget.articleImage,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          return frame != null
                              ? FittedBox(
                                  fit: BoxFit.fill,
                                  child: child,
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                    color: AutilabColor.bb,
                                  ),
                                );
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
                          width: 16,
                          height: 16,
                        ),
                      ),
                      const Text(
                        'Dr.Masoomi',
                        style: AutilabTextStyle.small14_400,
                      ),
                      const Spacer(),
                      Text(
                        '2 Days Ago',
                        style: AutilabTextStyle.small12_400
                            .copyWith(color: AutilabColor.gray),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    widget.articleTitle,
                    textAlign: TextAlign.justify,
                    style: AutilabTextStyle.medium20_500,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.articleDescription,
                    textAlign: TextAlign.justify,
                    style: AutilabTextStyle.small16_400,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FutureBuilder(
                    future: _futureText,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data ?? '',
                          style: AutilabTextStyle.small14_400,
                          textAlign: TextAlign.justify,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AutilabColor.drawerWhite,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        LikeWidget(
                          borderColor: Colors.transparent,
                          onTap: (isLike) {
                            setState(() {
                              isLike = !isLike;
                            });
                          },
                        ),
                        const Text(
                          'Add To Favorite',
                          style: AutilabTextStyle.small12_400,
                        ),
                      ],
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
    );
  }
}
