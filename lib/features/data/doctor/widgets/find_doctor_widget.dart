import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
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

  List<String> titleCategory = [
    'Behaviorism',
    'Pediatrician',
    'Physiotherapy',
    'Consultant',
    'Psychologist',
    'Speech therapy',
  ];

  List<String> imageCategory = [
    'assets/images/behaviorism_image.png',
    'assets/images/pediatrician_image.png',
    'assets/images/physiotherapy_image.png',
    'assets/images/conversation_image.png',
    'assets/images/psychologist_image.png',
    'assets/images/speech_therapy_image.png',
  ];
  List<Color> colorBoxCategory = const [
    Color(0xffC772FF),
    Color.fromRGBO(83, 226, 255, 0.7),
    Color(0xffFF7272),
    Color(0xff8AEDCE),
    Color(0xff5669FF),
    Color(0xffFFB253),
  ];

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
              borderRadius: BorderRadius.circular(16),
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
      width: 320,
      height: 467,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          SliverAppBar(
            pinned: true,
            toolbarHeight: 18,
            automaticallyImplyLeading: false,
            flexibleSpace: IconButton(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.centerLeft,
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
              icon: Row(
                children: [
                  const Icon(
                    Icons.close_rounded,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
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
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: colorBoxCategory.length,
              (context, index) {
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: colorBoxCategory[index],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          imageCategory[index],
                        ),
                        Text(
                          titleCategory[index],
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 24,
              mainAxisExtent: 113,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
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
      width: 320,
      height: 530,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 16,
            automaticallyImplyLeading: false,
            flexibleSpace: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                  icon: const Icon(Icons.close_rounded),
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
            child: Divider(
              thickness: 1,
              color: AutilabColor.gray,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: 168,
              child: ValueListenableBuilder(
                valueListenable: selectedIndexSpecialty,
                builder: (context, value, child) => GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 45,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 40,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return CustomButtonWidget(
                      margin: const EdgeInsets.all(0),
                      onTap: () {
                        selectedIndexSpecialty.value = index;
                      },
                      height: 100,
                      color: selectedIndexSpecialty.value == index
                          ? AutilabColor.bb
                          : AutilabColor.lightGray,
                      text: titleCategory[index],
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: AutilabColor.gray,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'Gender',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
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
          SliverToBoxAdapter(
            child: Text(
              'Rating',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
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
