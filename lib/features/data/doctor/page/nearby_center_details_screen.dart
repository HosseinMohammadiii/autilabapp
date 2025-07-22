import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/tool/widgets/populararticle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_textfield.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../tool/widgets/likewidget.dart';
import '../widgets/box_detail_widget.dart';
import '../widgets/button_card.dart';
import '../widgets/specialty_list_widget.dart';

// ignore: must_be_immutable
class NearbyCenterDetailsScreen extends StatefulWidget {
  NearbyCenterDetailsScreen({
    super.key,
    this.isLike,
  });
  bool? isLike;

  @override
  State<NearbyCenterDetailsScreen> createState() =>
      _NearbyCenterDetailsScreenState();
}

class _NearbyCenterDetailsScreenState extends State<NearbyCenterDetailsScreen>
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
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, title: 'Detail center', isIcon: true),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: TitleAndIconWidget(
                    icon: 'assets/icons/gallery.svg',
                    title: 'Photo Gallery',
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 150,
                  child: PageView.builder(
                    itemCount: 3,
                    padEnds: false,
                    pageSnapping: false,
                    controller: PageController(viewportFraction: 0.9),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: index == 0 ? 20 : 12,
                          right: index == 2 ? 8 : 0,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/centerImage.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: TitleAndIconWidget(
                    icon: 'assets/icons/info-circle.svg',
                    title: 'Center Information',
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 18,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 48),
                  decoration: BoxDecoration(
                    color: AutilabColor.primary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AutilabColor.gray),
                  ),
                  child: Column(
                    spacing: 12,
                    children: [
                      Text(
                        'At our autism services center, we empower individuals to embrace their unique strengths and unlock their full potential through personalized support.',
                        style: AutilabTextStyle.small14_400,
                        textAlign: TextAlign.justify,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: AutilabColor.bb,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: LikeWidget(
                              isLike: widget.isLike ?? false,
                              backgroundColor: AutilabColor.bb,
                              onTap: () {
                                setState(() {
                                  isLike = !isLike;
                                  widget.isLike = isLike;
                                });
                              },
                            ),
                          ),
                          ButtonCard(
                            onTap: () {
                              context.pushNamed(
                                AutiLabRoutes.doctorMessageScreen,
                                extra: {
                                  'image':
                                      'assets/images/autism_help_center.png',
                                  'name': 'Autism Help Center',
                                  'expertise': '',
                                },
                              );
                            },
                            margin: const EdgeInsets.all(0),
                            icon: 'assets/icons/messages.svg',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: TitleAndIconWidget(
                    icon: 'assets/icons/house_icon.svg',
                    title: 'Public Details',
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: BoxDetailWidget(
                      title: 'Full Name', subtitle: 'Autism Help Center'),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 8,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: BoxDetailWidget(title: 'For Ages', subtitle: '6-18'),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 8,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: BoxDetailWidget(title: 'Gender', subtitle: 'Both'),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: TitleAndIconWidget(
                    icon: 'assets/icons/people.svg',
                    title: 'Specialists',
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 80,
                  child: SpecialtiesListWidget(
                    height: 80,
                    width: 80,
                    heightImage: 32,
                    widthImage: 32,
                    radius: 16,
                    itemCount: 1,
                    textStyle: AutilabTextStyle.small10_400,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: TitleAndIconWidget(
                    icon: 'assets/icons/location-tick.svg',
                    title: 'Center Address',
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTextfield(
                  label: '',
                  isEnable: false,
                  borderRaduis: 16,
                  textfieldPadding: AutilabMargin.marginFullScreen,
                  controller: TextEditingController(
                    text:
                        '1234 Maple Street - Suite 567, Downtown Building -Toronto, ON M5A 1A1 - Canada',
                  ),
                  backgroundColor: AutilabColor.primary,
                  borderColor: AutilabColor.gray,
                  textStyle: AutilabTextStyle.small14_400.copyWith(
                    color: AutilabColor.black,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: TitleAndIconWidget(
                    icon: 'assets/icons/call-calling.svg',
                    title: 'Clinic Phone',
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTextfield(
                  label: '',
                  isEnable: false,
                  borderRaduis: 16,
                  textfieldPadding:
                      AutilabMargin.marginFullScreen.copyWith(top: 24),
                  controller: TextEditingController(
                    text: '+1 123456789',
                  ),
                  backgroundColor: AutilabColor.primary,
                  borderColor: AutilabColor.gray,
                  textStyle: AutilabTextStyle.small14_400.copyWith(
                    color: AutilabColor.black,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleAndIconWidget extends StatelessWidget {
  const TitleAndIconWidget({
    super.key,
    this.icon,
    required this.title,
    this.textStyle,
    this.isMobile = true,
    this.isShowIcon = true,
  });
  final bool isMobile;
  final String? icon;
  final String title;
  final TextStyle? textStyle;
  final bool isShowIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: isShowIcon,
          child: SvgPicture.asset(icon ?? 'assets/icons/location-tick.svg'),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          title,
          style: textStyle ?? AutilabTextStyle.medium18_500,
        ),
      ],
    );
  }
}
