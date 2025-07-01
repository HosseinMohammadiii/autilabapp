import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/specialty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/appbar_back_screen.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../../../core/constants/constant_routes.dart';
import '../widgets/box_detail_widget.dart';
import '../widgets/button_card.dart';
import '../widgets/personal_detail_widget.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key});

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  List<String> icon = [
    'assets/icons/global_buttomnavigation.svg',
    'assets/icons/messages.svg',
    'assets/icons/calendar.svg',
    'assets/icons/heart.svg',
  ];
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
                        Flexible(
                          child: SizedBox(
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
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 24,
                            children: [
                              const FittedBox(
                                child: Text(
                                  'Dr. Sophia Martinez',
                                  style: AutilabTextStyle.medium18_500,
                                ),
                              ),
                              FittedBox(
                                child: SizedBox(
                                  height: 32,
                                  width: 186,
                                  child: ListView.builder(
                                    itemCount: 4,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ButtonCard(
                                        onTap: () {
                                          switch (index) {
                                            case 0:
                                              context.pushNamed(AutiLabRoutes
                                                  .doctorSocialMediaScreen);
                                            case 1:
                                              context.pushNamed(
                                                AutiLabRoutes
                                                    .doctorMessageScreen,
                                                extra: {
                                                  'image':
                                                      'assets/images/doctor_image.jpg',
                                                },
                                              );
                                            case 2:
                                              context.pushNamed(AutiLabRoutes
                                                  .doctorWorkscheduleScreen);
                                            default:
                                          }
                                        },
                                        icon: icon[index],
                                      );
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
                child: PersonalDetailWidget(),
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
                child: Text(
                  'Specialty',
                  style: AutilabTextStyle.medium18_500,
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
                child: Text(
                  'More details',
                  style: AutilabTextStyle.medium18_500,
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
