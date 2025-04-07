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
                  Expanded(
                    child: Text(
                      'Specialties',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AutilabColor.blue,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              _listCategory(),
              Padding(
                padding: const EdgeInsets.only(top: 48, bottom: 8),
                child: Text(
                  'Expert Doctors',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
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

//Widget for display Specialties category list
  Widget _listCategory() {
    return SizedBox(
      height: 113,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: titleCategory.length,
        itemBuilder: (context, index) {
          return Container(
            height: 113,
            width: 132,
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorBoxCategory[index],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(imageCategory[index]),
                Text(
                  titleCategory[index],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

//Widget for display Specialties category dialog
  Widget _buildSpecialtiesDialog(
    BuildContext context,
    Function(int index) onTap,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.68,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 22,
            automaticallyImplyLeading: false,
            leadingWidth: double.infinity,
            leading: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      GoRouter.of(context).pop();
                    }
                  },
                  child: const Icon(Icons.close_rounded),
                ),
                const SizedBox(width: 8),
                Text(
                  'All Specialties',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: colorBoxCategory.length,
              (context, index) {
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorBoxCategory[index],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Image.asset(
                            imageCategory[index],
                            width: 56,
                            height: 56,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          titleCategory[index],
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.06,
              mainAxisSpacing: MediaQuery.of(context).size.width * 0.06,
              mainAxisExtent: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final showFullScreenDialog = MediaQuery.sizeOf(context).width < 600;
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
                Text(
                  'Filter',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    selectedIndexSpecialty.value = null;
                    selectedIndexNotifier.value = null;
                    selectedIndexrating.value = null;
                  },
                  child: Text(
                    'Rest Filter',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
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
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          // const SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 5,
          //   ),
          // ),
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
                    text: titleCategory[index],
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
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
          SliverToBoxAdapter(
            child: Text(
              'Gender',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
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
          SliverToBoxAdapter(
            child: Text(
              'Rating',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
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
