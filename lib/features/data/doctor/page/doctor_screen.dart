import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/drawer_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/widgets/appbar_widget.dart';
import '../../../../common/widgets/cached_network_image_widget.dart';
import '../../../../common/widgets/custom_tabbar_widget.dart';
import '../../../../core/constants/color_constant.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with SingleTickerProviderStateMixin {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  List<String> title1 = [
    'My Doctors',
    'All Appointment',
    'Messages',
    'My Subscribtion',
  ];
  List<String> icon1 = [
    'assets/icons/doctor_buttomnavigation.svg',
    'assets/icons/calendar.svg',
    'assets/icons/messages.svg',
    'assets/icons/crown.svg',
  ];

  List<String> title2 = [
    'Notification',
    'Test History',
    'My Favorite',
  ];
  List<String> icon2 = [
    'assets/icons/notification_icon.svg',
    'assets/icons/archive_icon.svg',
    'assets/icons/heart.svg',
  ];
  List<String> title3 = [
    'About AutiLab',
    'Log Out',
  ];
  List<String> icon3 = [
    'assets/icons/lamp_charge_icon.svg',
    'assets/icons/logout.svg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: AutilabColor.backgroundDrawer,
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: 104,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AutilabColor.drawerWhite,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Alexei Oppana',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'alexei@gmail.com',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        CustomButtonWidget(
                          onTap: () {},
                          width: 86,
                          height: 31,
                          margin: const EdgeInsets.all(0),
                          color: AutilabColor.blue,
                          text: 'Edit Profile',
                          textStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AutilabColor.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachednetworkimageWidget(
                      imgUrl: '',
                      img: Image.asset('assets/images/child_image.png'),
                      isNetworkImage: false,
                    ),
                  ),
                ],
              ),
              DrawerBoxWidget(
                icon: icon1,
                title: title1,
                color: const [
                  Color(0xffF3C58D),
                  Color(0xff8DAFFD),
                  Color(0xff7EECC5),
                  Color(0xffE4D080),
                ],
                onTap: (index) {},
              ),
              DrawerBoxWidget(
                icon: icon2,
                title: title2,
                color: const [
                  Color(0xff7EC9F8),
                  Color(0xffB4A7FF),
                  Color(0xffEA87F5),
                ],
                onTap: (index) {},
              ),
              DrawerBoxWidget(
                icon: icon3,
                title: title3,
                color: const [
                  Color(0xffDB9088),
                  Color(0xff3D90E0),
                ],
                onTap: (index) {},
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: CustomTabBarWidget(
          leading: appBarWidget(context),
          tabLength: 2,
          tabBar: const [
            Text('Find Doctor'),
            Text('Nearby centers'),
          ],
          tabBarView: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode: searchFocusNode,
                            controller: searchController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              prefixIcon: SvgPicture.asset(
                                fit: BoxFit.none,
                                'assets/icons/search_icon.svg',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: const BorderSide(
                                  color: AutilabColor.black,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: const BorderSide(
                                  color: AutilabColor.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: const BorderSide(
                                  color: AutilabColor.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            onChanged: (value) {},
                            onTapOutside: (event) {
                              //Unfocus TextField
                              searchFocusNode.unfocus();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(
                          fit: BoxFit.none,
                          'assets/icons/sort_icon.svg',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 10),
                      shrinkWrap: true,
                      itemCount: 40,
                      itemBuilder: (context, index) => Text('data $index'),
                    ),
                  ],
                ),
              ),
            ),
            Text('data2'),
          ],
        ),
      ),
    );
  }
}
