import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/data/doctor/page/doctor_screen.dart';
import '../../features/data/doctor/widgets/drawer_box_widget.dart';
import 'cached_network_image_widget.dart';
import 'custom_button_widget.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ButtomnavigationWidget extends StatefulWidget {
  const ButtomnavigationWidget({super.key});

  @override
  State<ButtomnavigationWidget> createState() => _ButtomnavigationWidgetState();
}

class _ButtomnavigationWidgetState extends State<ButtomnavigationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideTransition;
  int _selectedItem = 0;

  List<Widget> pageViewWidget = [
    const DoctorScreen(),
    const DoctorScreen(),
    const DoctorScreen(),
    const DoctorScreen(),
  ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: const Icon(Icons.menu),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Current location',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AutilabColor.gray,
                        ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/gps.svg'),
                        Text(
                          'Toronto,Canada',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
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
      ),
      bottomNavigationBar: Container(
        height: 94,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AutilabColor.black.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          elevation: 0,
          unselectedLabelStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AutilabColor.black,
                  ),
          selectedLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                //color: AutilabColor.black,
              ),
          currentIndex: _selectedItem,
          onTap: (index) {
            setState(() {
              _selectedItem = index;
            });
          },
          items: [
            _bottomnavigationItem(
              index: 0,
              selctItems: _selectedItem,
              lable: 'Home',
              icon: 'assets/icons/home_buttomnavigation.svg',
              context: context,
            ),
            _bottomnavigationItem(
              index: 1,
              selctItems: _selectedItem,
              lable: 'Doctor',
              icon: 'assets/icons/doctor_buttomnavigation.svg',
              context: context,
            ),
            _bottomnavigationItem(
              index: 2,
              selctItems: _selectedItem,
              lable: 'Tools',
              icon: 'assets/icons/tools_buttomnavigation.svg',
              context: context,
            ),
            _bottomnavigationItem(
              index: 3,
              selctItems: _selectedItem,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Denis Iliev',
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
                                'denis@gmail.com',
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
      ),
      body: pageViewWidget.elementAt(_selectedItem),
    );
  }

  Color setColorItems(int index, int selctItems) {
    return index == selctItems ? AutilabColor.bb : Colors.transparent;
  }

//This widget for set bottomnavigation items values
  BottomNavigationBarItem _bottomnavigationItem({
    required int index,
    required int selctItems,
    required String lable,
    required String icon,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 65,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: setColorItems(index, selctItems),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
            ),
            Text(lable),
          ],
        ),
      ),
      label: '',
    );
  }
}
