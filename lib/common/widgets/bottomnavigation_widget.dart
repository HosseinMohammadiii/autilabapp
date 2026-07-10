import 'dart:io';

import 'package:autilab_project/common/widgets/responsive_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_state.dart';
import 'package:autilab_project/features/data/auth/presentetion/page/edit_profile_screen.dart';
import 'package:autilab_project/features/data/doctor/presentation/page/doctor_screen.dart';
import 'package:autilab_project/features/data/home/presentation/page/home_screen.dart';
import 'package:autilab_project/features/data/tool/page/tools_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../features/data/auth/presentetion/bloc/auth_bloc.dart';
import '../../features/data/auth/presentetion/bloc/auth_event.dart';
import '../../features/data/doctor/widgets/drawer_box_widget.dart';
import '../../utils/functions/cacheimahe_function.dart';
import 'cached_network_image_widget.dart';

class ButtomnavigationWidget extends StatefulWidget {
  const ButtomnavigationWidget({
    super.key,
    // required this.navigationShell,
  });

  /// The navigation shell and container for the branch Navigators.
  // final StatefulNavigationShell navigationShell;
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
    // DrawerItemClass(
    //   'My Subscribtion',
    //   'assets/icons/crown.svg',
    //   const Color(0xffE4D080),
    // ),
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
  List<Widget> pageViewWidget = [
    const HomeScreen(),
    const DoctorScreen(),
    const ToolsScreen(),
    const EditProfileScreen(),
  ];

  int index = 0;
  int selectIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideTransition = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    // BlocProvider.of<AuthenticationBloc>(context).add(DisplayInformationUser());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isMainScreen() {
    List<String> locationList = [
      'homeScreen',
      'doctorScreen',
      'toolsScreen',
      'profileScreen',
    ];
    if (locationList.contains(GoRouterState.of(context).uri.path)) {
      return true;
    } else {
      return false;
    }
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

        return PopScope(
          canPop: selectIndex != 0 ? false : true,
          onPopInvokedWithResult: (didPop, result) {
            // if (GoRouterState.of(context).uri.path != 'homeScreen') {
            //   context.go('homeScreen');
            // }
            setState(() {
              selectIndex = 0;
            });
          },
          child: ResponsiveLayout(
            child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
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
                        child: Icon(
                          Icons.menu,
                          size: isMobile() ? 24 : 40,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your Location',
                            style: AutilabTextStyle.small16_400.copyWith(
                              color: AutilabColor.gray,
                              fontSize: isMobile() ? 16 : 28,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              spacing: 2,
                              children: [
                                SvgPicture.asset('assets/icons/gps.svg'),
                                Text(
                                  'Toronto,Canada',
                                  style: AutilabTextStyle.small18_400.copyWith(
                                    fontSize: isMobile() ? 18 : 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectIndex = 3;
                          });
                        },
                        child:
                            BlocBuilder<ProfileBlocLocal, AuthenticationState>(
                          builder: (context, state) {
                            // if (state is AuthenticationLoading) {
                            //   return Center(
                            //     child: Shimmer.fromColors(
                            //       baseColor: const Color(0xffE1E1E1),
                            //       highlightColor: const Color(0xffF3F3F2),
                            //       child: Container(
                            //         width: isMobile() ? 52 : 84,
                            //         height: isMobile() ? 52 : 84,
                            //         decoration: BoxDecoration(
                            //           color: Colors.grey,
                            //           borderRadius: BorderRadius.circular(100),
                            //         ),
                            //       ),
                            //     ),
                            //   );
                            // }
                            // if (state is FetchUserDataResponse) {
                            //   return state.response.fold(
                            //     (exception) {
                            //       return Center(
                            //         child: Text(exception),
                            //       );
                            //     },
                            //     (response) {
                            //       return ClipRRect(
                            //         borderRadius: BorderRadius.circular(100),
                            //         child: CachednetworkimageWidget(
                            //           width: isMobile() ? 52 : 84,
                            //           height: isMobile() ? 52 : 84,
                            //           imgUrl: response.photo,
                            //           img: Image.asset(
                            //             'assets/images/child2_image.jpg',
                            //             fit: BoxFit.cover,
                            //             width: isMobile() ? 52 : 84,
                            //             height: isMobile() ? 52 : 84,
                            //             cacheWidth: cacheImageFunction(
                            //                 isMobile() ? 100 : 100, context),
                            //             cacheHeight: cacheImageFunction(
                            //                 isMobile() ? 100 : 100, context),
                            //           ),
                            //           isNetworkImage: true,
                            //         ),
                            //       );
                            //     },
                            //   );
                            // }

                            if (state is UpdateLocalUserData) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachednetworkimageWidget(
                                  width: isMobile() ? 52 : 84,
                                  height: isMobile() ? 52 : 84,
                                  imgUrl: '',
                                  img: Image.file(
                                    File(state.response.photo!),
                                    fit: BoxFit.cover,
                                    width: isMobile() ? 52 : 84,
                                    height: isMobile() ? 52 : 84,
                                    cacheWidth: cacheImageFunction(
                                        isMobile() ? 100 : 100, context),
                                    cacheHeight: cacheImageFunction(
                                        isMobile() ? 100 : 100, context),
                                  ),
                                  isNetworkImage: false,
                                ),
                              );
                            }

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachednetworkimageWidget(
                                width: isMobile() ? 52 : 84,
                                height: isMobile() ? 52 : 84,
                                imgUrl: '',
                                img: Image.asset(
                                  'assets/images/child2_image.jpg',
                                  fit: BoxFit.cover,
                                  width: isMobile() ? 52 : 84,
                                  height: isMobile() ? 52 : 84,
                                  cacheWidth: cacheImageFunction(
                                      isMobile() ? 100 : 100, context),
                                  cacheHeight: cacheImageFunction(
                                      isMobile() ? 100 : 100, context),
                                ),
                                isNetworkImage: false,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Container(
                  height: isMobile() ? 97 : 126,
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
                        isMobile: isMobile(),
                        index: 0,
                        selctItems: selectIndex,
                        lable: 'Home',
                        icon: 'assets/icons/home_buttomnavigation.svg',
                        context: context,
                      ),
                      _bottomnavigationItem(
                        isMobile: isMobile(),
                        index: 1,
                        selctItems: selectIndex,
                        lable: 'Doctor',
                        icon: 'assets/icons/doctor_buttomnavigation.svg',
                        context: context,
                      ),
                      _bottomnavigationItem(
                        isMobile: isMobile(),
                        index: 2,
                        selctItems: selectIndex,
                        lable: 'Tools',
                        icon: 'assets/icons/tools_buttomnavigation.svg',
                        context: context,
                      ),
                      _bottomnavigationItem(
                        isMobile: isMobile(),
                        index: 3,
                        selctItems: selectIndex,
                        lable: 'Profile',
                        icon: 'assets/icons/profile_buttomnavigation.svg',
                        context: context,
                      ),
                    ],
                  ),
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
                        // Stack(
                        //   alignment: Alignment.topCenter,
                        //   children: [
                        // FittedBox(
                        //   child: Container(
                        //     height: 124,
                        //     margin: const EdgeInsets.only(
                        //         left: 20, right: 20, top: 36, bottom: 8),
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 16, vertical: 25),
                        //     decoration: BoxDecoration(
                        //       color: AutilabColor.drawerWhite,
                        //       borderRadius: BorderRadius.circular(16),
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.end,
                        //       spacing: 22,
                        //       children: [
                        //         const Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           mainAxisAlignment: MainAxisAlignment.end,
                        //           children: [
                        //             Text(
                        //               'Denis Iliev',
                        //               style: AutilabTextStyle.medium16_500,
                        //             ),
                        //             SizedBox(
                        //               height: 4,
                        //             ),
                        //             Text(
                        //               'denis@gmail.com',
                        //               style: AutilabTextStyle.small14_400,
                        //             ),
                        //           ],
                        //         ),
                        //         CustomButtonWidget(
                        //           onTap: () {
                        //             context.pop();
                        //             context.pushNamed(
                        //                 AutiLabRoutes.editProfileScreen);
                        //           },
                        //           width: 100,
                        //           height: 32,
                        //           borderRadius: 12,
                        //           margin: const EdgeInsets.all(0),
                        //           color: AutilabColor.blue,
                        //           text: 'Edit Profile',
                        //           textStyle:
                        //               AutilabTextStyle.small12_400.copyWith(
                        //             color: AutilabColor.white,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        //     ClipRRect(
                        //       borderRadius: BorderRadius.circular(100),
                        //       child: CachednetworkimageWidget(
                        //         imgUrl: '',
                        //         img: Image.asset(
                        //           'assets/images/child2_image.jpg',
                        //           fit: BoxFit.cover,
                        //           width: 72,
                        //           height: 72,
                        //         ),
                        //         isNetworkImage: false,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        DrawerBoxWidget(
                          isMobile: isMobile(),
                          drawerItem: firstDrawerItemList,
                          onTap: (index) {
                            switch (index) {
                              case 0:
                                context.pushNamed(AutiLabRoutes.myDoctorScreen);
                                break;

                              case 1:
                                context.pushNamed(
                                    AutiLabRoutes.allAppointmentScreen);
                                break;

                              case 2:
                                context.pushNamed(
                                    AutiLabRoutes.messageProfileScreen);
                                break;

                              // case 3:
                              //   context.pushNamed(
                              //       AutiLabRoutes.subscribtionScreen);
                              //   break;
                            }
                          },
                        ),
                        DrawerBoxWidget(
                          isMobile: isMobile(),
                          drawerItem: secondDrawerItemList,
                          onTap: (index) {
                            switch (index) {
                              case 0:
                                context.pushNamed(
                                    AutiLabRoutes.notificationScreen);
                                break;

                              case 1:
                                context.pushNamed(
                                    AutiLabRoutes.testHistoryScreen,
                                    pathParameters: {
                                      'initialPage': '0',
                                    });
                                break;

                              case 2:
                                context
                                    .pushNamed(AutiLabRoutes.myFavoriteScreen);
                                break;
                            }
                          },
                        ),
                        DrawerBoxWidget(
                          isMobile: isMobile(),
                          drawerItem: thirdDrawerItemList,
                          onTap: (index) {
                            switch (index) {
                              case 0:
                                context.pushNamed(AutiLabRoutes.aboutScreen);
                                break;
                              case 1:
                                context.pushNamed(AutiLabRoutes.welcomeScreen);
                                SharedPreferencesData.userLogIn(false);
                                break;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: pageViewWidget[selectIndex],
            ),
          ),
        );
      },
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
    required bool isMobile,
  }) {
    return GestureDetector(
      // onTap: () => widget.navigationShell.goBranch(index),
      onTap: () {
        setState(() {
          selectIndex = index;
        });
      },
      child: Container(
        width: isMobile ? 72 : 92,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: setColorItems(index, selctItems),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          spacing: isMobile ? 6 : 8,
          children: [
            SvgPicture.asset(
              icon,
              width: isMobile ? 32 : 40,
              height: isMobile ? 32 : 40,
            ),
            Text(
              lable,
              style: AutilabTextStyle.medium12_500.copyWith(
                fontSize: isMobile ? 12 : 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
