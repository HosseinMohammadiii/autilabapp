import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/functions/animation_control.dart';

class MainContentScreen extends StatefulWidget {
  const MainContentScreen({super.key});

  @override
  State<MainContentScreen> createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen>
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

  bool isLike = false;

  @override
  void didUpdateWidget(covariant MainContentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: AutilabMargin.marginFullScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/game_image.png',
                      height: 215,
                      fit: BoxFit.fitWidth,
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
                          'assets/images/doctor3.png',
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
                        '2 days ago',
                        style: AutilabTextStyle.small12_400
                            .copyWith(color: AutilabColor.gray),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Gaming And Autism',
                    style: AutilabTextStyle.medium20_500,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Balancing Screen Time For Kids',
                    style: AutilabTextStyle.small16_400,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Our design blog is your ultimate resource for all things design. From the latest trends in web design to the timeless principles of graphic design, we cover it all. Our team of expert designers and industry thought leaders share their insights, tips, and tricks on how to create visually stunning and effective designs that resonate with your target audience. Whether you're a professional designer, a design enthusiast, or just looking for some design inspiration, our blog is the perfect destination for you. Join us as we explore the art and science of design, and discover how you can take your designs to the next level.",
                    style: AutilabTextStyle.small16_400,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Our design blog is your ultimate resource for all things design. From the latest trends in web design to the timeless principles of graphic design, we cover it all. Our team of expert designers and industry thought leaders share their insights, tips, and tricks on how to create visually stunning and effective designs that resonate with your target audience. Whether you're a professional designer, a design enthusiast, or just looking for some design inspiration, our blog is the perfect destination for you. Join us as we explore the art and science of design, and discover how you can take your designs to the next level.",
                    style: AutilabTextStyle.small16_400,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLike = !isLike;
                          });
                        },
                        child: isLike
                            ? const Icon(
                                Icons.favorite_rounded,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border_rounded,
                              ),
                      ),
                      const Text(
                        '500 Likes',
                        style: AutilabTextStyle.small12_400,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SvgPicture.asset(
                        'assets/icons/messages.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      const Text(
                        '101 Comments',
                        style: AutilabTextStyle.small12_400,
                      ),
                    ],
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
