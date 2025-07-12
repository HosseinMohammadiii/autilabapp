import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/doctor_box_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/search_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/appbar_back_screen.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../../../utils/functions/custom_dialog_function.dart';
import '../widgets/custom_checkbox_widget.dart';

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
      appBar:
          appBarWidget(context: context, title: 'Specialties', isIcon: true),
      body: SafeArea(
        child: FadeTransition(
          opacity: animationHelper.fadeAnimation,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverAppBar(
                  leadingWidth: double.infinity,
                  pinned: true,
                  leading: Row(
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
                          showCustomDialog(
                            context,
                            _buildDialogSortIcon(
                              context,
                            ),
                          );
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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

  //Widget for display filter dialog
  Widget _buildDialogSortIcon(
    BuildContext context,
  ) {
    final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(null);
    final ValueNotifier<int?> selectedIndexSpecialty =
        ValueNotifier<int?>(null);
    final ValueNotifier<double?> selectedIndexrating =
        ValueNotifier<double?>(null);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 528, maxHeight: 342),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 4,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    child: const Icon(Icons.close_rounded),
                  ),
                  const Text(
                    'Filter',
                    style: AutilabTextStyle.small18_400,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      selectedIndexSpecialty.value = null;
                      selectedIndexNotifier.value = null;
                      selectedIndexrating.value = null;
                    },
                    child: const Text(
                      'Rest Filter',
                      style: AutilabTextStyle.medium12_500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(
                thickness: 1,
                color: AutilabColor.gray,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Gender',
                style: AutilabTextStyle.medium18_500,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomCheckbox(
                title: 'Male',
                index: 1,
                selectedIndexNotifier: selectedIndexNotifier,
              ),
              CustomCheckbox(
                title: 'Female',
                index: 2,
                selectedIndexNotifier: selectedIndexNotifier,
              ),
              const Divider(
                thickness: 1,
                color: AutilabColor.gray,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Rating',
                style: AutilabTextStyle.medium18_500,
              ),
              const SizedBox(
                height: 16,
              ),
              ValueListenableBuilder(
                valueListenable: selectedIndexrating,
                builder: (context, value, child) => RatingBar.builder(
                  initialRating: selectedIndexrating.value ?? 0,
                  itemCount: 5,
                  minRating: 1,
                  maxRating: 5,
                  updateOnDrag: true,
                  itemSize: 30,
                  unratedColor: AutilabColor.gray,
                  glow: false,
                  itemBuilder: (context, index) {
                    return const Icon(
                      Icons.star_rounded,
                      color: AutilabColor.yellow,
                      size: 24,
                    );
                  },
                  onRatingUpdate: (value) {
                    selectedIndexrating.value = value;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
