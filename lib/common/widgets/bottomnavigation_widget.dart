import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../features/data/doctor/widgets/drawer_box_widget.dart';
import 'cached_network_image_widget.dart';
import 'custom_button_widget.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ButtomnavigationWidget extends StatefulWidget {
  const ButtomnavigationWidget({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;
  @override
  State<ButtomnavigationWidget> createState() => _ButtomnavigationWidgetState();
}

class _ButtomnavigationWidgetState extends State<ButtomnavigationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideTransition;
  List<DrawerItemClass> firstDrawerItemList = [
    DrawerItemClass(
      'My Doctors',
      'assets/icons/doctor_buttomnavigation.svg',
      const Color(0xffF3C58D),
    ),
    DrawerItemClass(
      'All Appointment',
      'assets/icons/calendar.svg',
      const Color(0xff8DAFFD),
    ),
    DrawerItemClass(
      'Messages',
      'assets/icons/messages.svg',
      const Color(0xff7EECC5),
    ),
    DrawerItemClass(
      'My Subscribtion',
      'assets/icons/crown.svg',
      const Color(0xffE4D080),
    ),
  ];
  List<DrawerItemClass> secondDrawerItemList = [
    DrawerItemClass(
      'Notification',
      'assets/icons/notification_icon.svg',
      const Color(0xff7EC9F8),
    ),
    DrawerItemClass(
      'Test History',
      'assets/icons/archive_icon.svg',
      const Color(0xffB4A7FF),
    ),
    DrawerItemClass(
      'My Favorite',
      'assets/icons/heart.svg',
      const Color(0xffEA87F5),
    ),
  ];
  List<DrawerItemClass> thirdDrawerItemList = [
    DrawerItemClass(
      'About AutiLab',
      'assets/icons/lamp_charge_icon.svg',
      const Color(0xffDB9088),
    ),
    DrawerItemClass(
      'Log Out',
      'assets/icons/logout.svg',
      const Color(0xff3D90E0),
    ),
  ];

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _slideTransition = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isMainScreen() {
    List<String> locationList = [
      '/homeScreen',
      '/doctorScreen',
      '/toolsScreen',
      '/communityScreen',
      '/doctorSpecialityScreen',
      '/articleItemScreen',
    ];
    if (locationList.contains(GoRouterState.of(context).uri.path)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:
          GoRouterState.of(context).uri.path != '/homeScreen' ? false : true,
      onPopInvokedWithResult: (didPop, result) {
        if (GoRouterState.of(context).uri.path != '/homeScreen') {
          context.go('/homeScreen');
        }
      },
      child: Scaffold(
        // drawerScrimColor: Colors.transparent,
        key: scaffoldKey,
        appBar: isMainScreen()
            ? AppBar(
                leadingWidth: double.infinity,
                toolbarHeight: 100,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Wrap(
                    runAlignment: WrapAlignment.spaceBetween,
                    alignment: WrapAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      GestureDetector(
                        onTap: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        child: const Icon(Icons.menu),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Current location',
                            style: AutilabTextStyle.small16_400.copyWith(
                              color: AutilabColor.gray,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/gps.svg'),
                                const Text(
                                  'Toronto,Canada',
                                  style: AutilabTextStyle.small18_400,
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachednetworkimageWidget(
                          imgUrl: '',
                          img: Image.asset(
                            'assets/images/child2_image.jpg',
                            fit: BoxFit.cover,
                            width: 52,
                            height: 52,
                          ),
                          isNetworkImage: false,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
        bottomNavigationBar: Container(
          height: 95,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: AutilabColor.white,
            boxShadow: [
              BoxShadow(
                color: AutilabColor.black.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _bottomnavigationItem(
                index: 0,
                selctItems: widget.navigationShell.currentIndex,
                lable: 'Home',
                icon: 'assets/icons/home_buttomnavigation.svg',
                context: context,
              ),
              _bottomnavigationItem(
                index: 1,
                selctItems: widget.navigationShell.currentIndex,
                lable: 'Doctor',
                icon: 'assets/icons/doctor_buttomnavigation.svg',
                context: context,
              ),
              _bottomnavigationItem(
                index: 2,
                selctItems: widget.navigationShell.currentIndex,
                lable: 'Tools',
                icon: 'assets/icons/tools_buttomnavigation.svg',
                context: context,
              ),
              _bottomnavigationItem(
                index: 3,
                selctItems: widget.navigationShell.currentIndex,
                lable: 'Community',
                icon: 'assets/icons/global_buttomnavigation.svg',
                context: context,
              ),
            ],
          ),
        ),
        onDrawerChanged: (isOpened) {
          setState(() {
            isPlaying = isOpened;
            isOpened
                ? _animationController.forward()
                : _animationController.reverse();
          });
        },
        drawer: SafeArea(
          child: SlideTransition(
            position: _slideTransition,
            child: Drawer(
              backgroundColor: AutilabColor.backgroundDrawer,
              elevation: 0,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        // width: double.infinity,
                        height: 124,
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 36, bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 25),
                        decoration: BoxDecoration(
                          color: AutilabColor.drawerWhite,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Denis Iliev',
                                  style: AutilabTextStyle.medium16_500,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'denis@gmail.com',
                                  style: AutilabTextStyle.small14_400,
                                ),
                              ],
                            ),
                            const Spacer(),
                            CustomButtonWidget(
                              onTap: () {
                                context.pop();
                                context
                                    .pushNamed(AutiLabRoutes.editProfileScreen);
                              },
                              width: 100,
                              height: 32,
                              borderRadius: 12,
                              margin: const EdgeInsets.all(0),
                              color: AutilabColor.blue,
                              text: 'Edit Profile',
                              textStyle: AutilabTextStyle.small12_400.copyWith(
                                color: AutilabColor.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachednetworkimageWidget(
                          imgUrl: '',
                          img: Image.asset(
                            'assets/images/child2_image.jpg',
                            fit: BoxFit.cover,
                            width: 72,
                            height: 72,
                          ),
                          isNetworkImage: false,
                        ),
                      ),
                    ],
                  ),
                  DrawerBoxWidget(
                    drawerItem: firstDrawerItemList,
                    onTap: (index) {
                      context.pop();

                      switch (index) {
                        case 1:
                          context.pushNamed(AutiLabRoutes.allAppointmentScreen);
                        case 2:
                          context.pushNamed(AutiLabRoutes.messageProfileScreen);
                        case 3:
                          context.pushNamed(AutiLabRoutes.subscribtionScreen);
                      }
                    },
                  ),
                  DrawerBoxWidget(
                    drawerItem: secondDrawerItemList,
                    onTap: (index) {
                      context.pop();

                      switch (index) {
                        case 0:
                          context.pushNamed(AutiLabRoutes.notificationScreen);
                        case 1:
                          context.pushNamed(AutiLabRoutes.testHistoryScreen);
                        case 2:
                          context.pushNamed(AutiLabRoutes.myFavoriteScreen);
                      }
                    },
                  ),
                  DrawerBoxWidget(
                    drawerItem: thirdDrawerItemList,
                    onTap: (index) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: widget.navigationShell,
      ),
    );
  }

  Color setColorItems(int index, int selctItems) {
    return index == selctItems ? AutilabColor.bb : Colors.transparent;
  }

//This widget for set bottomnavigation items values
  Widget _bottomnavigationItem({
    required int index,
    required int selctItems,
    required String lable,
    required String icon,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => widget.navigationShell.goBranch(index),
      child: Container(
        width: 72,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: setColorItems(index, selctItems),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
            ),
            Text(
              lable,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
