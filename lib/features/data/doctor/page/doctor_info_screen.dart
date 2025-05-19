import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/appbar_back_screen.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../utils/Lists/category_items.dart';
import '../widgets/box_detail_widget.dart';
import '../widgets/button_card.dart';
import '../widgets/container_more_detail_widget.dart';
import '../widgets/personal_detail_widget.dart';
import '../widgets/specialty_item_widget.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height: 136,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 22),
                  decoration: BoxDecoration(
                    color: AutilabColor.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 24,
                    children: [
                      FittedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/doctor_image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 24,
                          children: [
                            const Text(
                              'Dr. Sophia Martinez',
                              style: AutilabTextStyle.medium18_500,
                            ),
                            SizedBox(
                              height: 32,
                              child: ListView.builder(
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ButtonCard(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          context.pushNamed(AutiLabRoutes
                                              .doctorSocialMediaScreen);
                                        case 1:
                                          context.pushNamed(AutiLabRoutes
                                              .doctorMessageScreen);
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
                          ],
                        ),
                      ),
                    ],
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
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              const SliverToBoxAdapter(
                child: PersonalDetailWidget(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              const SliverToBoxAdapter(
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
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(
                  thickness: 1,
                  color: AutilabColor.gray,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,
                ),
              ),
              const SliverToBoxAdapter(
                child: Text(
                  'Specialty',
                  style: AutilabTextStyle.medium18_500,
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
                  child: ListView.builder(
                    itemCount: categoryItemsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index == categoryItemsList.length - 1 ? 0 : 16,
                        ),
                        child: SpecialtyItemWidget(
                          index: index,
                          onTap: () {
                            context.pushNamed(
                                AutiLabRoutes.doctorSpecialityScreen);
                          },
                        ),
                      );
                    },
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
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,
                ),
              ),
              const SliverToBoxAdapter(
                child: Text(
                  'More details',
                  style: AutilabTextStyle.medium18_500,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              const SliverToBoxAdapter(
                child: ContainerDetailBox(
                  detail:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequatenim ad minim veniam, quis nostrud exercitation ullamco laboris',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
