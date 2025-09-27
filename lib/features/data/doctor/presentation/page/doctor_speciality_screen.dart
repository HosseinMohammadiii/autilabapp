import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/data/model/all_doctor_model.dart';
import 'package:autilab_project/features/data/doctor/widgets/doctor_box_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/search_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widgets/appbar_back_screen.dart';
import '../../../../../common/widgets/custom_button_widget.dart';
import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../core/constants/color_constant.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../utils/functions/custom_dialog_function.dart';
import '../../widgets/custom_checkbox_widget.dart';

class DoctorSpecialityScreen extends StatefulWidget {
  const DoctorSpecialityScreen({
    super.key,
    this.doctorList,
  });
  final List<AllDoctorModel>? doctorList;

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
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile() {
          if (constraints.maxWidth < 600) {
            return true;
          } else {
            return false;
          }
        }

        return ResponsiveLayout(
          child: FadeTransition(
            opacity: animationHelper.fadeAnimation,
            child: Scaffold(
              appBar: appBarWidget(
                context: context,
                title: 'Specialties',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: FadeTransition(
                  opacity: animationHelper.fadeAnimation,
                  child: CustomScrollView(
                    slivers: [
                      if (!isMobile()) ...[
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 32,
                          ),
                        ),
                      ],
                      SliverPadding(
                        padding: AutilabMargin.marginFullScreen,
                        sliver: SliverAppBar(
                          leadingWidth: double.infinity,
                          toolbarHeight: 90,
                          pinned: true,
                          leading: Row(
                            spacing: 8,
                            children: [
                              Expanded(
                                child: SearchTextFieldWidget(
                                  isMobile: isMobile(),
                                  searchFocusNode: searchFocusNode,
                                  searchController: searchController,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: AutilabColor.bb,
                                  shape: BoxShape.circle,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    showCustomDialog(
                                      context,
                                      _buildDialogSortIcon(
                                        context,
                                        isMobile(),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: isMobile() ? 25 : 88,
                                    child: SvgPicture.asset(
                                      'assets/icons/sort_icon.svg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
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
                      SliverPadding(
                        padding: AutilabMargin.marginFullScreen,
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Doctor Specialty',
                            style: AutilabTextStyle.small24_400.copyWith(
                              fontSize: isMobile() ? 24 : 32,
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      SliverList.builder(
                        itemCount: widget.doctorList?.length == null
                            ? 0
                            : widget.doctorList!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DoctorBoxWidget(
                              isMobile: isMobile(),
                              doctorSpecialities:
                                  widget.doctorList?[index].specialities,
                              user: widget.doctorList?[index].user,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //Widget for display filter dialog
  Widget _buildDialogSortIcon(
    BuildContext context,
    final bool isMobile,
  ) {
    final ValueNotifier<bool> selectedGenderMaleNotifier =
        ValueNotifier<bool>(true);
    final ValueNotifier<bool> selectedGenderFemaleNotifier =
        ValueNotifier<bool>(false);
    final ValueNotifier<int?> selectedIndexSpecialty =
        ValueNotifier<int?>(null);
    final ValueNotifier<double?> selectedIndexrating =
        ValueNotifier<double?>(null);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 528, maxHeight: 524),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  Text(
                    'Filter',
                    style: AutilabTextStyle.small18_400.copyWith(
                      fontSize: isMobile ? 18 : 20,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      selectedIndexSpecialty.value = null;
                      selectedGenderMaleNotifier.value = false;
                      selectedGenderFemaleNotifier.value = false;
                      selectedIndexrating.value = null;
                    },
                    child: Text(
                      'Rest Filter',
                      style: AutilabTextStyle.small14_500.copyWith(
                        fontSize: isMobile ? 14 : 16,
                      ),
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
              Text(
                'Gender',
                style: AutilabTextStyle.medium18_500.copyWith(
                  fontSize: isMobile ? 18 : 20,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomCheckbox(
                isMobile: isMobile,
                title: 'Male',
                textStyle: AutilabTextStyle.small14_400.copyWith(
                  fontSize: isMobile ? 14 : 20,
                ),
                index: 1,
                selectedIndexNotifier: selectedGenderMaleNotifier,
                onChanged: (value) {
                  setState(() {
                    selectedGenderMaleNotifier.value =
                        !selectedGenderMaleNotifier.value;
                    value = selectedGenderMaleNotifier.value;
                  });
                },
              ),
              CustomCheckbox(
                isMobile: isMobile,
                title: 'Female',
                textStyle: AutilabTextStyle.small14_400.copyWith(
                  fontSize: isMobile ? 14 : 20,
                ),
                index: 2,
                selectedIndexNotifier: selectedGenderFemaleNotifier,
                onChanged: (value) {
                  setState(() {
                    selectedGenderFemaleNotifier.value =
                        !selectedGenderFemaleNotifier.value;
                    value = selectedGenderFemaleNotifier.value;
                  });
                },
              ),
              const Divider(
                thickness: 1,
                color: AutilabColor.gray,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Rating',
                style: AutilabTextStyle.medium18_500.copyWith(
                  fontSize: isMobile ? 18 : 20,
                ),
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
                  itemSize: isMobile ? 30 : 45,
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
              CustomButtonWidget(
                isMobile: isMobile,
                onTap: () {
                  context.pop();
                },
                height: 50,
                margin: const EdgeInsets.only(top: 24),
                color: AutilabColor.bb,
                text: 'Search',
                textStyle: AutilabTextStyle.small18_400,
              ),
            ],
          ),
        );
      },
    );
  }
}
