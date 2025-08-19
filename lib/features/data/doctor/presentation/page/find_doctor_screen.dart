import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/data/model/all_doctor_model.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/doctor_event.dart';
import 'package:autilab_project/features/data/doctor/presentation/bloc/doctor_state.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';
import 'package:autilab_project/presentation/screens/not_connection_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widgets/custom_button_widget.dart';
import '../../../../../common/widgets/loading_indicator_widget.dart';
import '../../../../../core/constants/color_constant.dart';
import '../../../../../utils/Lists/category_items.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../utils/functions/cacheimahe_function.dart';
import '../../../../../utils/functions/custom_dialog_function.dart';
import '../../widgets/custom_checkbox_widget.dart';
import '../../widgets/doctor_box_widget.dart';
import '../../widgets/search_textfield_widget.dart';
import '../../widgets/specialty_list_widget.dart';

class FindDoctorScreen extends StatefulWidget {
  const FindDoctorScreen({super.key});

  @override
  State<FindDoctorScreen> createState() => _FindDoctorScreenState();
}

class _FindDoctorScreenState extends State<FindDoctorScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  late List<AllDoctorModel> doctorsList = [];
  late List<RecentVisitedModel> specialtyList = [];

  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  bool isChecked = false;

  bool icConnected = true;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    BlocProvider.of<DoctorBloc>(context).add(DisplayDoctors());
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FindDoctorScreen oldWidget) {
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

        return FadeTransition(
          opacity: animationHelper.fadeAnimation,
          child: BlocConsumer<DoctorBloc, DoctorState>(
            listener: (context, state) {
              if (state is AllDoctorResponseState) {
                doctorsList = state.displayAllDoctor;
                specialtyList = state.displayAllSpecialty;
              }
            },
            builder: (context, state) {
              if (state is DoctorError) {
                if (state.errorMessage.type ==
                    DioExceptionType.connectionError) {
                  return NotConnectionInternetScreen(
                    onChange: () async {
                      context.read<DoctorBloc>().add(DisplayDoctors());
                    },
                  );
                }
              }
              if (state is DoctorLoading) {
                return const LoadingProgressWidget();
              }

              return RefreshIndicator(
                color: AutilabColor.bb,
                onRefresh: () async {
                  context.read<DoctorBloc>().add(DisplayDoctors());
                },
                child: Scaffold(
                  body: SafeArea(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Padding(
                                padding: AutilabMargin.marginFullScreen,
                                child: Row(
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
                              const SizedBox(
                                height: 32,
                              ),
                              Padding(
                                padding: AutilabMargin.marginFullScreen,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Specialties',
                                        style: AutilabTextStyle.small20_400
                                            .copyWith(
                                                fontSize: isMobile() ? 20 : 32),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showCustomDialog(
                                          context,
                                          _buildSpecialtiesDialog(
                                            context,
                                            (index) {},
                                            isMobile(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'See All',
                                        style: AutilabTextStyle.medium14_500
                                            .copyWith(
                                          color: AutilabColor.blue,
                                          fontSize: isMobile() ? 14 : 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              SpecialtiesListWidget(
                                itemCount: specialtyList.length,
                                recentModel: specialtyList,
                                height: isMobile() ? 113 : 180,
                                width: isMobile() ? 112 : 180,
                                widthImage: isMobile() ? 56 : 76,
                                heightImage: isMobile() ? 56 : 76,
                                radius: isMobile() ? 24 : 40,
                                textStyle: isMobile()
                                    ? AutilabTextStyle.small14_400
                                    : AutilabTextStyle.small20_400,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 48, bottom: 16, right: 20, left: 20),
                                child: Text(
                                  'Specialist',
                                  style: AutilabTextStyle.small20_400
                                      .copyWith(fontSize: isMobile() ? 20 : 32),
                                ),
                              ),
                              Padding(
                                padding: AutilabMargin.marginFullScreen,
                                child: ListView.builder(
                                  itemCount: doctorsList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return DoctorBoxWidget(
                                      isMobile: isMobile(),
                                      isLike: false,
                                      gender: doctorsList[index].user?.gender ??
                                          'male',
                                      user: doctorsList[index].user,
                                      doctorSpecialities:
                                          doctorsList[index].specialities,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

// //Widget for display Specialties category dialog
  Widget _buildSpecialtiesDialog(
    BuildContext context,
    Function(int index) onTap,
    final bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 32, vertical: isMobile ? 16 : 32),
      constraints: const BoxConstraints(
        maxWidth: 512,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => GoRouter.of(context).pop(),
                child: const Icon(Icons.close_rounded),
              ),
              const SizedBox(width: 8),
              Text(
                'All Specialties',
                style: AutilabTextStyle.medium18_500.copyWith(
                  fontSize: isMobile ? 18 : 20,
                ),
              ),
            ],
          ),
          GridView.builder(
            padding: const EdgeInsets.only(top: 24),
            itemCount: categoryItemsList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: isMobile ? 113 : 200,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onTap(index),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: categoryItemsList[index].color,
                    borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: Image.asset(
                          categoryItemsList[index].image,
                          width: isMobile ? 56 : 96,
                          height: isMobile ? 56 : 96,
                          cacheWidth:
                              cacheImageFunction(isMobile ? 56 : 96, context),
                          cacheHeight:
                              cacheImageFunction(isMobile ? 56 : 96, context),
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          categoryItemsList[index].title,
                          textAlign: TextAlign.center,
                          style: AutilabTextStyle.medium14_500.copyWith(
                            fontSize: isMobile ? 14 : 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

//Widget for display filter dialog
  Widget _buildDialogSortIcon(
    BuildContext context,
    final bool isMobile,
  ) {
    final ValueNotifier<bool?> selectedGenderMaleNotifier =
        ValueNotifier<bool?>(true);
    final ValueNotifier<bool?> selectedGenderFemaleNotifier =
        ValueNotifier<bool?>(false);
    final ValueNotifier<bool?> selectedIndexNotifier =
        ValueNotifier<bool?>(false);
    final ValueNotifier<int?> selectedIndexSpecialty =
        ValueNotifier<int?>(null);
    final ValueNotifier<double?> selectedIndexrating =
        ValueNotifier<double?>(null);

    return FittedBox(
      child: Container(
        constraints: BoxConstraints(
            maxWidth: isMobile ? 320 : 528, maxHeight: isMobile ? 685 : 884),
        padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32, vertical: isMobile ? 16 : 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  child: Icon(
                    Icons.close_rounded,
                    size: isMobile ? 20 : 40,
                  ),
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
                    selectedIndexNotifier.value = null;
                    selectedIndexrating.value = null;
                    selectedGenderMaleNotifier.value = false;
                    selectedGenderFemaleNotifier.value = false;
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
              height: 10,
            ),
            const Divider(
              thickness: 1,
              color: AutilabColor.gray,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Doctor's specialty",
              style: AutilabTextStyle.medium18_500.copyWith(
                fontSize: isMobile ? 18 : 20,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: selectedIndexSpecialty,
              builder: (context, value, child) => GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 24),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: isMobile ? 16 : 32,
                  mainAxisSpacing: isMobile ? 8 : 16,
                  mainAxisExtent: isMobile ? 52 : 80,
                ),
                itemCount: categoryItemsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedIndexSpecialty.value = index;
                    },
                    child: Container(
                      height: isMobile ? 50 : 72,
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedIndexSpecialty.value == index
                            ? AutilabColor.bb
                            : AutilabColor.lightGray,
                        borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          categoryItemsList[index].title,
                          textAlign: TextAlign.center,
                          style: AutilabTextStyle.small14_500
                              .copyWith(fontSize: isMobile ? 14 : 20),
                        ),
                      ),
                    ),
                  );
                },
              ),
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
                  if (value != null) {
                    selectedGenderMaleNotifier.value =
                        !selectedGenderMaleNotifier.value!;
                  }
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
                  if (value != null) {
                    selectedGenderFemaleNotifier.value =
                        !selectedGenderFemaleNotifier.value!;
                    value = selectedGenderFemaleNotifier.value!;
                  }
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
            Spacer(),
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
      ),
    );
  }
}
