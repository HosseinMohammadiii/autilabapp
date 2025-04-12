import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/appbar_back_screen.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../utils/Lists/category_items.dart';
import '../widgets/button_card.dart';
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
                            Text(
                              'Dr. Sophia Martinez',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
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
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/profile_icon.svg'),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Personal Details',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              const BoxDetailNearbyCenterAndDoctorInfo(
                title: 'Full Name',
                subtitle: 'Dr. Sophia Martinez',
              ),
              const BoxDetailNearbyCenterAndDoctorInfo(
                title: "Doctor's Degree",
                subtitle: 'Phd',
              ),
              const BoxDetailNearbyCenterAndDoctorInfo(
                title: 'Age',
                subtitle: '30',
              ),
              const BoxDetailNearbyCenterAndDoctorInfo(
                title: 'Gender',
                subtitle: 'ّFemale',
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
              SliverToBoxAdapter(
                child: Text(
                  'Specialty',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
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
                  child: ListView.builder(
                    itemCount: categoryItemsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SpecialtyItemWidget(
                        index: index,
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
              SliverToBoxAdapter(
                child: Text(
                  'More details',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height / 3,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 48),
                  decoration: BoxDecoration(
                    color: AutilabColor.primary,
                    border: Border.all(width: 0.5, color: AutilabColor.gray),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequatenim ad minim veniam, quis nostrud exercitation ullamco laboris',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxDetailNearbyCenterAndDoctorInfo extends StatelessWidget {
  const BoxDetailNearbyCenterAndDoctorInfo({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xffECF0FF),
          border: Border.all(width: 0.5, color: AutilabColor.bb),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
