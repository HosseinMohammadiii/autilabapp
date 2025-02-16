import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/appbar_widget.dart';
import '../../../../common/widgets/cached_network_image_widget.dart';
import '../../../../common/widgets/custom_tabbar_widget.dart';
import '../../../../core/constants/color_constant.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      body: SafeArea(
        child: CustomTabBarWidget(
          //leading: appBarWidget(context),
          tabLength: 2,
          tabBar: const [
            Text('Find Doctor'),
            Text('Nearby centers'),
          ],
          tabBarView: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
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
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showCustomDialog(
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
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Specialties',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showCustomDialog(
                              context,
                              _buildDialogContent(
                                context,
                                (index) {},
                              ),
                            );
                          },
                          child: Text(
                            'See All',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AutilabColor.blue,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Text('data2'),
          ],
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context, Widget widget) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: Dialog(
            backgroundColor: AutilabColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  Widget _buildDialogContent(
    BuildContext context,
    Function(int index) onTap,
  ) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                icon: const Icon(Icons.close_rounded),
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
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: titleCategory.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    width: 132,
                    alignment: Alignment.center,
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
          ),
        ],
      ),
    );
  }

  Widget _buildDialogSortIcon(
    BuildContext context,
  ) {
    final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(null);
    final ValueNotifier<int?> selectedIndexSpecialty =
        ValueNotifier<int?>(null);
    final ValueNotifier<double?> selectedIndexrating =
        ValueNotifier<double?>(null);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(8),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 35,
            leadingWidth: double.infinity,
            backgroundColor: AutilabColor.white,
            leading: Row(
              children: [
                IconButton(
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
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
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
              height: 173,
              child: ValueListenableBuilder(
                valueListenable: selectedIndexSpecialty,
                builder: (context, value, child) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 45,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3.5,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return CustomButtonWidget(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      onTap: () {
                        selectedIndexSpecialty.value = index;
                      },
                      height: 37,
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
                  ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
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
                itemSize: 24,
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

class CustomCheckbox extends StatelessWidget {
  final String title;
  final int index;
  final ValueNotifier<int?> selectedIndexNotifier;

  const CustomCheckbox({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 52,
              width: 40,
              child: Checkbox(
                activeColor: AutilabColor.blue,
                checkColor: AutilabColor.white,
                side: const BorderSide(width: 0.5),
                splashRadius: 0,
                value: selectedIndex == index,
                onChanged: (value) {
                  if (value == true) {
                    selectedIndexNotifier.value = index;
                  }
                },
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        );
      },
    );
  }
}
