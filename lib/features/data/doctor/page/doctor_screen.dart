import 'package:autilab_project/features/data/doctor/widgets/find_doctor_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_tabbar_widget.dart';

import '../widgets/nearby_center_widget.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomTabBarWidget(
          tabLength: 2,
          tabBar: [
            FittedBox(
              child: Text(
                'Find Doctor',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            FittedBox(
              child: Text(
                'Nearby centers',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ],
          tabBarView: const [
            FindDoctorWidget(),
            NearbyCenterWidget(),
          ],
        ),
      ),
    );
  }
}
