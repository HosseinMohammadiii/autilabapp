import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/doctor_box_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/search_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/functions/animation_control.dart';

class DoctorSpecialityScreen extends StatefulWidget {
  const DoctorSpecialityScreen({super.key});

  @override
  State<DoctorSpecialityScreen> createState() => _DoctorSpecialityScreenState();
}

class _DoctorSpecialityScreenState extends State<DoctorSpecialityScreen>
    with SingleTickerProviderStateMixin {
  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();
  late AnimationHelper animationHelper;
  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DoctorSpecialityScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: animationHelper.fadeAnimation,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: SearchTextFieldWidget(
                            searchFocusNode: searchFocusNode,
                            searchController: searchController,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // showCustomDialog(
                          //   context,
                          //   _buildDialogSortIcon(
                          //     context,
                          //   ),
                          // );
                        },
                        child: SvgPicture.asset(
                          fit: BoxFit.none,
                          'assets/icons/sort_icon.svg',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Doctor Specialty',
                    style: AutilabTextStyle.small24_400,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              SliverList.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DoctorBoxWidget(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
