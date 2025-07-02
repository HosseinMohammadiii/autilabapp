import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/specialty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/appbar_back_screen.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../tool/widgets/likewidget.dart';
import '../widgets/box_detail_widget.dart';
import '../widgets/button_card.dart';
import 'nearby_center_details_screen.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key});

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          context: context, title: 'Info Specialties', isIcon: true),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height: 136,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 22),
                  decoration: BoxDecoration(
                    color: AutilabColor.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: SizedBox(
                    height: 116,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 24,
                      children: [
                        SizedBox(
                          height: 116,
                          width: 116,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/doctor_image.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 24,
                            children: [
                              const FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Dr. Sophia Martinez',
                                  style: AutilabTextStyle.medium18_500,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonCard(
                                    margin: EdgeInsets.zero,
                                    icon:
                                        'assets/icons/global_buttomnavigation.svg',
                                    onTap: () {
                                      context.pushNamed(AutiLabRoutes
                                          .doctorSocialMediaScreen);
                                    },
                                  ),
                                  ButtonCard(
                                    margin: EdgeInsets.zero,
                                    icon: 'assets/icons/messages.svg',
                                    onTap: () {
                                      context.pushNamed(
                                        AutiLabRoutes.doctorMessageScreen,
                                        extra: {
                                          'image':
                                              'assets/images/doctor_image.jpg',
                                        },
                                      );
                                    },
                                  ),
                                  ButtonCard(
                                    margin: EdgeInsets.zero,
                                    icon: 'assets/icons/calendar.svg',
                                    onTap: () {
                                      context.pushNamed(AutiLabRoutes
                                          .doctorWorkscheduleScreen);
                                    },
                                  ),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AutilabColor.bb,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: LikeWidget(
                                      onTap: (isLike) {},
                                    ),
                                  ),
                                ],
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
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: Divider(
                  thickness: 1,
                  color: AutilabColor.gray,
                  indent: 20,
                  endIndent: 20,
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
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: Column(
                  spacing: 12,
                  children: [
                    BoxDetailWidget(
                      title: 'Full Name',
                      subtitle: 'Dr. Sophia Martinez',
                    ),
                    BoxDetailWidget(
                      title: "Doctor's Degree",
                      subtitle: 'Phd',
                    ),
                    BoxDetailWidget(
                      title: 'Age',
                      subtitle: '30',
                    ),
                    BoxDetailWidget(
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
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: TitleAndIconWidget(
                  icon: 'assets/icons/profile_icon.svg',
                  title: "Doctor's specialty",
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                child: SpecialtiesListWidget(
                  height: 80,
                  width: 80,
                  heightImage: 32,
                  widthImage: 32,
                  radius: 16,
                  textStyle: AutilabTextStyle.small10_400,
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
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: TitleAndIconWidget(
                  icon: 'assets/icons/info-circle.svg',
                  title: 'More details',
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
                child: CustomTextfield(
                  label: '',
                  isEnable: false,
                  borderRaduis: 24,
                  textfieldPadding: const EdgeInsets.all(0),
                  controller: TextEditingController(
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  ),
                  backgroundColor: AutilabColor.primary,
                  borderColor: AutilabColor.gray,
                  textStyle: AutilabTextStyle.small14_400.copyWith(
                    color: AutilabColor.black,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
