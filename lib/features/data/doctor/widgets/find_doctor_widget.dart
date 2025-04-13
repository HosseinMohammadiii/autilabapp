import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../utils/Lists/category_items.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../../../utils/functions/custom_dialog_function.dart';
import 'custom_checkbox_widget.dart';
import 'doctor_box_widget.dart';
import 'specialty_list_widget.dart';

class FindDoctorWidget extends StatefulWidget {
  const FindDoctorWidget({super.key});

  @override
  State<FindDoctorWidget> createState() => _FindDoctorWidgetState();
}

class _FindDoctorWidgetState extends State<FindDoctorWidget>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  bool isChecked = false;

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
  void didUpdateWidget(covariant FindDoctorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        focusNode: searchFocusNode,
                        controller: searchController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          prefixIcon: SvgPicture.asset(
                            fit: BoxFit.none,
                            'assets/icons/search_icon.svg',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                              color: AutilabColor.black,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                              color: AutilabColor.black,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                              color: AutilabColor.black,
                              width: 1,
                            ),
                          ),
                        ),
                        onChanged: (value) {},
                        onTapOutside: (event) {
                          //Unfocus TextField
                          searchFocusNode.unfocus();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
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
              const SizedBox(
                height: 48,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Specialties',
                      style: AutilabTextStyle.small24_400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showCustomDialog(
                        context,
                        _buildSpecialtiesDialog(
                          context,
                          (index) {},
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: AutilabTextStyle.medium14_500.copyWith(
                        color: AutilabColor.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const SpecialtiesListWidget(),
              const Padding(
                padding: EdgeInsets.only(top: 48, bottom: 8),
                child: Text(
                  'Expert Doctors',
                  style: AutilabTextStyle.small24_400,
                ),
              ),
              ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const DoctorBoxWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

//Widget for display Specialties category dialog
  Widget _buildSpecialtiesDialog(
    BuildContext context,
    Function(int index) onTap,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      constraints: const BoxConstraints(
        maxWidth: 320,
        maxHeight: 470,
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () => GoRouter.of(context).pop(),
                child: const Icon(Icons.close_rounded),
              ),
              const SizedBox(width: 8),
              const Text(
                'All Specialties',
                style: AutilabTextStyle.small18_400,
              ),
            ],
          ),
          // const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              itemCount: categoryItemsList.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                mainAxisExtent: 113,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: categoryItemsList[index].color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Image.asset(
                            categoryItemsList[index].image,
                            width: 56,
                            height: 56,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          categoryItemsList[index].title,
                          textAlign: TextAlign.center,
                          style: AutilabTextStyle.medium14_500,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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

    return Container(
      constraints: const BoxConstraints(maxWidth: 320, maxHeight: 559),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 21,
            automaticallyImplyLeading: false,
            leadingWidth: double.infinity,
            leading: Row(
              spacing: 4,
              children: [
                GestureDetector(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.close_rounded),
                  ),
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
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: AutilabColor.gray,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              "Doctor's specialty",
              style: AutilabTextStyle.medium18_500,
            ),
          ),
          SliverToBoxAdapter(
            child: ValueListenableBuilder(
              valueListenable: selectedIndexSpecialty,
              builder: (context, value, child) => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 37,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return CustomButtonWidget(
                    margin: const EdgeInsets.all(0),
                    onTap: () {
                      selectedIndexSpecialty.value = index;
                    },
                    height: 0,
                    color: selectedIndexSpecialty.value == index
                        ? AutilabColor.bb
                        : AutilabColor.lightGray,
                    text: categoryItemsList[index].title,
                    textStyle: AutilabTextStyle.small14_500,
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: AutilabColor.gray,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          const SliverToBoxAdapter(
            child: Text(
              'Gender',
              style: AutilabTextStyle.medium18_500,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomCheckbox(
              title: 'Male',
              index: 1,
              selectedIndexNotifier: selectedIndexNotifier,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomCheckbox(
              title: 'Female',
              index: 2,
              selectedIndexNotifier: selectedIndexNotifier,
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: AutilabColor.gray,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          const SliverToBoxAdapter(
            child: Text(
              'Rating',
              style: AutilabTextStyle.medium18_500,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: ValueListenableBuilder(
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
          ),
        ],
      ),
    );
  }
}
