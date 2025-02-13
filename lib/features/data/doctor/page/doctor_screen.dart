import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/drawer_box_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar_widget.dart';
import '../../../../common/widgets/cached_network_image_widget.dart';
import '../../../../core/constants/color_constant.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
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
      appBar: appBarWidget(context),
      drawer: Drawer(
        backgroundColor: AutilabColor.backgroundDrawer,
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: 104,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
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
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
              decoration: BoxDecoration(
                color: AutilabColor.drawerWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DrawerBoxWidget(icon: icon1, title: title1, color: const [
                Color(0xffF3C58D),
                Color(0xff8DAFFD),
                Color(0xff7EECC5),
                Color(0xffE4D080),
              ]),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
              decoration: BoxDecoration(
                color: AutilabColor.drawerWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DrawerBoxWidget(icon: icon2, title: title2, color: const [
                Color(0xffF3C58D),
                Color(0xff8DAFFD),
                Color(0xff7EECC5),
                Color(0xffE4D080),
              ]),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
              decoration: BoxDecoration(
                color: AutilabColor.drawerWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DrawerBoxWidget(icon: icon3, title: title3, color: const [
                Color(0xffF3C58D),
                Color(0xff8DAFFD),
                Color(0xff7EECC5),
                Color(0xffE4D080),
              ]),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [],
        ),
      ),
    );
  }
}
