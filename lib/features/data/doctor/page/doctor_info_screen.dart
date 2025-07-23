import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/specialty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/appbar_back_screen.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../tool/widgets/likewidget.dart';
import '../widgets/box_detail_widget.dart';
import '../widgets/button_card.dart';
import 'nearby_center_details_screen.dart';

// ignore: must_be_immutable
class DoctorInfoScreen extends StatefulWidget {
  DoctorInfoScreen({
    super.key,
    this.isLike = false,
  });
  bool isLike;

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen>
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
  void didUpdateWidget(covariant DoctorInfoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile() {
        if (constraints.maxWidth < 600) {
          return true;
        } else {
          return false;
        }
      }

      return FadeTransition(
        opacity: animationHelper.fadeAnimation,
        child: Scaffold(
            appBar: appBarWidget(
              context: context,
              title: "The Specialists' Info",
              isIcon: true,
              isMobile: isMobile(),
            ),
            body: SafeArea(
                child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: AutilabMargin.marginFullScreen,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      height: isMobile() ? 136 : 248,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(top: 22),
                      decoration: BoxDecoration(
                        color: AutilabColor.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: SizedBox(
                        height: isMobile() ? 116 : 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 24,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: isMobile() ? 116 : 200,
                                width: isMobile() ? 116 : 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    'assets/images/doctor_image.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 24,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Dr. Sophia Martinez',
                                      style: isMobile()
                                          ? AutilabTextStyle.medium18_500
                                          : AutilabTextStyle.medium18_500
                                              .copyWith(fontSize: 32),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      spacing: 22,
                                      children: [
                                        // FittedBox(
                                        //   fit: BoxFit.scaleDown,
                                        //   alignment: Alignment.centerLeft,
                                        //   child: ButtonCard(
                                        //     margin: EdgeInsets.zero,
                                        //     icon:
                                        //         'assets/icons/global_buttomnavigation.svg',
                                        //     onTap: () {
                                        //       context.pushNamed(AutiLabRoutes
                                        //           .doctorSocialMediaScreen);
                                        //     },
                                        //   ),
                                        // ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: ButtonCard(
                                            isMobile: isMobile(),
                                            margin: EdgeInsets.zero,
                                            icon: 'assets/icons/messages.svg',
                                            onTap: () {
                                              context.pushNamed(
                                                AutiLabRoutes
                                                    .doctorMessageScreen,
                                                extra: {
                                                  'image':
                                                      'assets/images/doctor_image.jpg',
                                                  'name': 'Dr. Sophia Martinez',
                                                  'expertise': 'Speech Therapy',
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: ButtonCard(
                                            isMobile: isMobile(),
                                            margin: EdgeInsets.zero,
                                            icon: 'assets/icons/calendar.svg',
                                            onTap: () {
                                              context.pushNamed(
                                                AutiLabRoutes
                                                    .doctorWorkscheduleScreen,
                                                extra: {
                                                  'isLike': widget.isLike,
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: isMobile() ? 32 : 68,
                                            height: isMobile() ? 32 : 68,
                                            decoration: BoxDecoration(
                                              color: AutilabColor.bb,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      isMobile() ? 12 : 24),
                                            ),
                                            child: LikeWidget(
                                              isMobile: isMobile(),
                                              backgroundColor:
                                                  Colors.transparent,
                                              isLike: widget.isLike,
                                              onTap: () {
                                                setState(() {
                                                  widget.isLike =
                                                      !widget.isLike;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    thickness: 1,
                    color: AutilabColor.gray,
                    indent: 20,
                    endIndent: 20,
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
                      icon: 'assets/icons/profile_icon.svg',
                      title: 'Personal Details',
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
                    child: Column(
                      spacing: 12,
                      children: [
                        BoxDetailWidget(
                          isMobile: isMobile(),
                          title: 'Full Name',
                          subtitle: 'Dr. Sophia Martinez',
                        ),
                        BoxDetailWidget(
                          isMobile: isMobile(),
                          title: "Doctor's Degree",
                          subtitle: 'Phd',
                        ),
                        BoxDetailWidget(
                          isMobile: isMobile(),
                          title: 'Age',
                          subtitle: '30',
                        ),
                        BoxDetailWidget(
                          isMobile: isMobile(),
                          title: 'Gender',
                          subtitle: 'ّFemale',
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    thickness: 1,
                    color: AutilabColor.gray,
                    indent: 20,
                    endIndent: 20,
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
                      icon: 'assets/icons/profile_icon.svg',
                      title: "Doctor's Specialty",
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
                    height: isMobile() ? 90 : 174,
                    child: SpecialtiesListWidget(
                      isMobile: isMobile(),
                      height: isMobile() ? 80 : 174,
                      width: isMobile() ? 80 : 174,
                      heightImage: isMobile() ? 32 : 72,
                      widthImage: isMobile() ? 32 : 72,
                      radius: isMobile() ? 16 : 24,
                      itemCount: 1,
                      textStyle: AutilabTextStyle.small10_400.copyWith(
                        fontSize: isMobile() ? 10 : 20,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    thickness: 1,
                    color: AutilabColor.gray,
                    indent: 20,
                    endIndent: 20,
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
                      title: 'Clinic Address',
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
                    borderRaduis: isMobile() ? 16 : 24,
                    textfieldPadding: AutilabMargin.marginFullScreen,
                    padding: EdgeInsets.all(isMobile() ? 16 : 24),
                    controller: TextEditingController(
                      text:
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
                    label: '',
                    isEnable: false,
                    borderRaduis: isMobile() ? 16 : 24,
                    padding: EdgeInsets.all(isMobile() ? 16 : 24),
                    textfieldPadding:
                        AutilabMargin.marginFullScreen.copyWith(top: 24),
                    controller: TextEditingController(
                      text: '+1 123456789',
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
                      icon: 'assets/icons/info-circle.svg',
                      title: 'More Details',
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CustomTextfield(
                    label: '',
                    isEnable: false,
                    borderRaduis: isMobile() ? 16 : 24,
                    padding: EdgeInsets.all(isMobile() ? 16 : 24),
                    textfieldPadding:
                        AutilabMargin.marginFullScreen.copyWith(top: 24),
                    controller: TextEditingController(
                      text:
                          "Hi, I’m Dr. Sophia Martinez – a speech therapist with over 8 years of experience helping children with autism, speech delays, and communication challenges.My goal is to support every child in finding their unique voice — with patience, care, and family collaboration.You can easily book a session or consultation through this app. I’d be honored to support your child’s journey.",
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
                    height: 48,
                  ),
                ),
              ],
            ))),
      );
    });
  }
}
