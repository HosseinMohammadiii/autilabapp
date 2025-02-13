import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/data/doctor/page/doctor_screen.dart';

class ButtomnavigationWidget extends StatefulWidget {
  const ButtomnavigationWidget({super.key});

  @override
  State<ButtomnavigationWidget> createState() => _ButtomnavigationWidgetState();
}

class _ButtomnavigationWidgetState extends State<ButtomnavigationWidget> {
  int _selectedItem = 0;

  List<Widget> pageViewWidget = [
    const DoctorScreen(),
    const DoctorScreen(),
    const DoctorScreen(),
    const DoctorScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 94,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AutilabColor.black.withOpacity(0.3),
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
              lable: 'Tools',
              icon: 'assets/icons/tools_buttomnavigation.svg',
              context: context,
            ),
            _bottomnavigationItem(
              index: 2,
              selctItems: _selectedItem,
              lable: 'Doctor',
              icon: 'assets/icons/doctor_buttomnavigation.svg',
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
      body: pageViewWidget[0],
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
              // colorFilter: ColorFilter.mode(
              //   state == index ? Theme.of(context).primaryColor : Colors.black,
              //   BlendMode.srcIn,
              // ),
            ),
            Text(lable),
          ],
        ),
      ),
      label: ' 1',
    );
  }
}
