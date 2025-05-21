import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/functions/animation_control.dart';

class WhiteboardScreen extends StatefulWidget {
  const WhiteboardScreen({super.key});

  @override
  State<WhiteboardScreen> createState() => _WhiteboardScreenState();
}

class _WhiteboardScreenState extends State<WhiteboardScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    animationHelper.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WhiteboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            // spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 12,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      const Text(
                        'Setting',
                        style: AutilabTextStyle.small12_400,
                      ),
                      SvgPicture.asset('assets/icons/arrow_down.svg'),
                    ],
                  ),
                  CustomButtonWhiteBoardWidget(
                    onTap: () {},
                    width: 78,
                    height: 24,
                    color: const Color(0xffE74747),
                    icon: 'logout.svg',
                    title: 'End',
                  ),
                ],
              ),
              CustomButtonWhiteBoardWidget(
                onTap: () {},
                width: 150,
                height: 30,
                color: AutilabColor.yellow,
                icon: 'messages.svg',
                title: 'Chat',
              ),
              BoxWhiteBoardWidget(
                onTapOne: () {},
                colorOne: AutilabColor.lightGray,
                iconOne: 'download.svg',
                titleOne: 'Download',
                onTapSecond: () {},
                colorSecond: AutilabColor.lightGray,
                iconSecond: 'upload.svg',
                titleSecond: 'Upload File',
              ),
              BoxWhiteBoardWidget(
                onTapOne: () {},
                colorOne: AutilabColor.bb,
                iconOne: 'video_call_icon.svg',
                titleOne: 'Webcam',
                onTapSecond: () {},
                colorSecond: AutilabColor.lightGray,
                iconSecond: 'brush.svg',
                titleSecond: 'Whiteboard',
              ),
              BoxWhiteBoardWidget(
                onTapOne: () {},
                colorOne: AutilabColor.lightGray,
                iconOne: 'screenmirroring.svg',
                titleOne: 'Share Screen',
                onTapSecond: () {},
                colorSecond: AutilabColor.bb,
                iconSecond: 'microphone.svg',
                titleSecond: 'Voice',
              ),
              Row(
                spacing: 8,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/doctor_image.png',
                      fit: BoxFit.cover,
                      width: 72,
                      height: 83,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/child2_image.jpg',
                      fit: BoxFit.cover,
                      width: 72,
                      height: 83,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxWhiteBoardWidget extends StatelessWidget {
  const BoxWhiteBoardWidget({
    super.key,
    required this.onTapOne,
    required this.colorOne,
    required this.iconOne,
    required this.titleOne,
    required this.onTapSecond,
    required this.colorSecond,
    required this.iconSecond,
    required this.titleSecond,
  });
  final Function() onTapOne;
  final Color colorOne;
  final String iconOne;
  final String titleOne;
  final Function() onTapSecond;
  final Color colorSecond;
  final String iconSecond;
  final String titleSecond;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Container(
          width: 72,
          height: 56,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colorOne,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              SvgPicture.asset('assets/icons/$iconOne'),
              Text(
                titleOne,
                style: AutilabTextStyle.small10_400,
              ),
            ],
          ),
        ),
        Container(
          width: 72,
          height: 56,
          decoration: BoxDecoration(
            color: colorSecond,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              SvgPicture.asset('assets/icons/$iconSecond'),
              Text(
                titleSecond,
                style: AutilabTextStyle.small10_400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomButtonWhiteBoardWidget extends StatelessWidget {
  const CustomButtonWhiteBoardWidget({
    super.key,
    required this.onTap,
    required this.width,
    required this.height,
    required this.color,
    required this.icon,
    required this.title,
  });
  final Function() onTap;
  final double width;
  final double height;
  final Color color;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/$icon'),
            Text(
              title,
              style: AutilabTextStyle.small12_400,
            ),
          ],
        ),
      ),
    );
  }
}
