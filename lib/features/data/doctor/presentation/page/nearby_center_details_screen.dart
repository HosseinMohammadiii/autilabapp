import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/cached_network_image_widget.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/data/model/center_model.dart';
import 'package:autilab_project/features/data/tool/widgets/populararticle_widget.dart';
import 'package:autilab_project/utils/functions/specifygender_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widgets/custom_textfield.dart';
import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../core/constants/color_constant.dart';
import '../../../../../core/constants/constant_routes.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../utils/functions/cacheimahe_function.dart';
import '../../../tool/widgets/likewidget.dart';
import '../../widgets/box_detail_widget.dart';
import '../../widgets/button_card.dart';

// ignore: must_be_immutable
class NearbyCenterDetailsScreen extends StatefulWidget {
  NearbyCenterDetailsScreen({
    super.key,
    this.isLike,
    this.centerModel,
  });
  bool? isLike;
  final CenterModel? centerModel;

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
                title: 'Detail center',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: TitleAndIconWidget(
                          isMobile: isMobile(),
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
                        height: isMobile() ? 150 : 309,
                        child: PageView.builder(
                          itemCount: widget.centerModel?.images.length ?? 3,
                          padEnds: false,
                          pageSnapping: false,
                          controller: PageController(viewportFraction: 0.9),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 20 : 8,
                                right: widget.centerModel?.images.length ==
                                        index - 1
                                    ? 0
                                    : 8,
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(isMobile() ? 16 : 24),
                                child: CachednetworkimageWidget(
                                    width: isMobile() ? 280 : 566,
                                    height: isMobile() ? 150 : 309,
                                    boxFit: BoxFit.cover,
                                    imgUrl: widget.centerModel?.images[index]
                                            .imageUrl ??
                                        '',
                                    img: Image.asset(
                                      'assets/images/centerImage.jpg',
                                      fit: BoxFit.cover,
                                      cacheWidth: cacheImageFunction(
                                          isMobile() ? 150 : 309, context),
                                      cacheHeight: cacheImageFunction(
                                          isMobile() ? 150 : 309, context),
                                    ),
                                    isNetworkImage: true),
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
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: TitleAndIconWidget(
                          isMobile: isMobile(),
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
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 48),
                        decoration: BoxDecoration(
                          color: AutilabColor.primary,
                          borderRadius:
                              BorderRadius.circular(isMobile() ? 16 : 24),
                          border: Border.all(color: AutilabColor.gray),
                        ),
                        child: Column(
                          spacing: 12,
                          children: [
                            Text(
                              widget.centerModel?.centerinformation ??
                                  'At our autism services center, we empower individuals to embrace their unique strengths and unlock their full potential through personalized support.',
                              style: AutilabTextStyle.small14_400.copyWith(
                                fontSize: isMobile() ? 14 : 24,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: isMobile() ? 32 : 68,
                                  height: isMobile() ? 32 : 68,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: AutilabColor.bb,
                                    borderRadius: BorderRadius.circular(
                                        isMobile() ? 12 : 24),
                                  ),
                                  child: LikeWidget(
                                    isMobile: isMobile(),
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
                                  isMobile: isMobile(),
                                  onTap: () {
                                    context.pushNamed(
                                      AutiLabRoutes.doctorMessageScreen,
                                      extra: {
                                        'image': widget.centerModel?.images[0]
                                                .imageUrl ??
                                            'assets/images/autism_help_center.png',
                                        'name': widget.centerModel?.name ??
                                            'Autism Help Center',
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
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: TitleAndIconWidget(
                          isMobile: isMobile(),
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
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: BoxDetailWidget(
                          isMobile: isMobile(),
                          title: 'Full Name',
                          subtitle:
                              widget.centerModel?.name ?? 'Autism Help Center',
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 8,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: BoxDetailWidget(
                          isMobile: isMobile(),
                          title: 'For Ages',
                          subtitle:
                              '${widget.centerModel?.agemin}-${widget.centerModel?.agemax}',
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 8,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: BoxDetailWidget(
                          isMobile: isMobile(),
                          title: 'Gender',
                          subtitle: displayGender(widget.centerModel!.gender),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    if (widget.centerModel!.specialty.isNotEmpty) ...[
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
                      SliverPadding(
                        padding: AutilabMargin.marginFullScreen,
                        sliver: SliverToBoxAdapter(
                          child: TitleAndIconWidget(
                            isMobile: isMobile(),
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
                          height: isMobile() ? 80 : 174,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.centerModel!.specialty.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: isMobile() ? 80 : 174,
                                width: isMobile() ? 80 : 174,
                                margin: const EdgeInsets.only(
                                  left: 20,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(widget.centerModel!
                                      .specialty[index].codeColor)),
                                  borderRadius: BorderRadius.circular(
                                    isMobile() ? 16 : 24,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      width: isMobile() ? 32 : 72,
                                      height: isMobile() ? 32 : 72,
                                      child: CachednetworkimageWidget(
                                        imgUrl: widget.centerModel!
                                            .specialty[index].imagePath,
                                        width: isMobile() ? 32 : 72,
                                        height: isMobile() ? 32 : 72,
                                        boxFit: BoxFit.scaleDown,
                                        isShowShimmer: false,
                                        borderRadius: 8,
                                        img: const Text(''),
                                        isNetworkImage: widget
                                                .centerModel!
                                                .specialty[index]
                                                .imagePath
                                                .isNotEmpty
                                            ? true
                                            : false,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          widget.centerModel!.specialty[index]
                                              .name
                                              .replaceAll(' ', '\n'),
                                          textAlign: TextAlign.center,
                                          style: AutilabTextStyle.small10_400
                                              .copyWith(
                                            fontSize: isMobile() ? 10 : 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: TitleAndIconWidget(
                          isMobile: isMobile(),
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
                        isMobile: isMobile(),
                        label: '',
                        isEnable: false,
                        borderRaduis: isMobile() ? 16 : 24,
                        textfieldPadding: AutilabMargin.marginFullScreen,
                        padding: EdgeInsets.all(isMobile() ? 16 : 24),
                        controller: TextEditingController(
                          text: widget.centerModel?.address ??
                              '1234 Maple Street - Suite 567, Downtown Building -Toronto, ON M5A 1A1 - Canada',
                        ),
                        backgroundColor: AutilabColor.primary,
                        borderColor: AutilabColor.gray,
                        textStyle: AutilabTextStyle.small14_400.copyWith(
                          color: AutilabColor.black,
                          fontSize: isMobile() ? 14 : 20,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: TitleAndIconWidget(
                          isMobile: isMobile(),
                          icon: 'assets/icons/call-calling.svg',
                          title: 'Clinic Phone',
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomTextfield(
                        isMobile: isMobile(),
                        label: '',
                        isEnable: false,
                        borderRaduis: isMobile() ? 16 : 24,
                        padding: EdgeInsets.all(isMobile() ? 16 : 24),
                        textfieldPadding:
                            AutilabMargin.marginFullScreen.copyWith(top: 24),
                        controller: TextEditingController(
                          text:
                              widget.centerModel?.phonenumber ?? '+1 123456789',
                        ),
                        backgroundColor: AutilabColor.primary,
                        borderColor: AutilabColor.gray,
                        textStyle: AutilabTextStyle.small14_400.copyWith(
                          color: AutilabColor.black,
                          fontSize: isMobile() ? 14 : 20,
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
          ),
        );
      },
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
          child: SvgPicture.asset(
            icon ?? 'assets/icons/location-tick.svg',
            width: isMobile ? 24 : 40,
            height: isMobile ? 24 : 40,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          title,
          style: textStyle ??
              AutilabTextStyle.medium18_500.copyWith(
                fontSize: isMobile ? 18 : 32,
              ),
        ),
      ],
    );
  }
}
