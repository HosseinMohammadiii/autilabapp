import 'dart:io';

import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/utils/functions/custom_dialog_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common/widgets/cached_network_image_widget.dart';
import '../../../../common/widgets/textfiledbox_description.dart';
import '../../../../utils/functions/animation_control.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final firstNameController = TextEditingController();
  final lasNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdayController = TextEditingController();
  final descriptionController = TextEditingController();

  final firstNameFocusNode = FocusNode();
  final lasNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final birthdayFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  final picker = ImagePicker();
  File? pickedFileGallery;
  XFile? pickedFile;

  final bool isImage = true;
  bool isSelectedDate = false;

  DateTime? _focusedDay;

  final ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  final String dateOfBirth = '';

  final List<String> genderOptions = ['Male', 'Female', 'Others'];
  String? selectedGender;
  bool isDropdownOpen = false;
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
  void didUpdateWidget(covariant EditProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

//Methode pickImage for select image from gallery or camera for profile image
  Future<void> pickImage({required Permission permission}) async {
    // Check the permission status
    var status = await permission.status;
    final imagePicker = ImagePicker();

    // Show modal bottom sheet to choose image source
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(
              'Gallery',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            onTap: () async {
              // Handle gallery image picking with permission
              if (status.isGranted) {
                // If permission already granted, pick image from gallery
                pickedFile =
                    await imagePicker.pickImage(source: ImageSource.gallery);
              } else if (status.isDenied) {
                // If permission is denied, request it
                if (await permission.request().isGranted) {
                  // If user grants permission, pick image
                  pickedFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                } else {
                  // If permission still denied, exit
                  return;
                }
              }

              setState(() {});
              Navigator.of(context).pop(); // Close bottom sheet
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: Text(
              'Camera',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            onTap: () async {
              // Handle camera image picking with permission
              if (status.isGranted) {
                // If permission already granted, pick image from camera
                pickedFile =
                    await imagePicker.pickImage(source: ImageSource.camera);
              } else if (status.isDenied) {
                // If permission is denied, request it
                if (await permission.request().isGranted) {
                  // If user grants permission, pick image
                  pickedFile =
                      await imagePicker.pickImage(source: ImageSource.camera);
                } else {
                  return;
                }
              } else {
                return;
              }

              setState(() {});
              Navigator.of(context).pop(); // Close bottom sheet
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar:
            appBarWidget(context: context, title: 'Edit Profile', isIcon: true),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      width: 104,
                      height: 104,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachednetworkimageWidget(
                              imgUrl: '',
                              img: pickedFile?.path != null
                                  ? Image.file(
                                      File(pickedFile!.path),
                                      fit: BoxFit.cover,
                                      width: 104,
                                      height: 104,
                                    )
                                  : Image.asset(
                                      'assets/images/child2_image.jpg',
                                      fit: BoxFit.cover,
                                      width: 104,
                                      height: 104,
                                    ),
                              isNetworkImage: false,
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            child: GestureDetector(
                              onTap: () {
                                pickImage(permission: Permission.storage);
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: AutilabColor.bb,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/camera.svg',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Denis Iliev',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      'Denis@gmail.com',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTextfield(
                  textInputAction: TextInputAction.next,
                  borderColor: AutilabColor.bb,
                  borderRaduis: 16,
                  backgroundColor: const Color(0xffECF0FF),
                  lblColor: AutilabColor.gray,
                  label: 'What’s your first name?',
                  controller: firstNameController,
                  focusNode: firstNameFocusNode,
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTextfield(
                  textInputAction: TextInputAction.next,
                  borderColor: AutilabColor.bb,
                  borderRaduis: 16,
                  backgroundColor: const Color(0xffECF0FF),
                  lblColor: AutilabColor.gray,
                  label: 'And your last name?',
                  controller: lasNameController,
                  focusNode: lasNameFocusNode,
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTextfield(
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  borderColor: AutilabColor.bb,
                  borderRaduis: 16,
                  backgroundColor: const Color(0xffECF0FF),
                  lblColor: AutilabColor.gray,
                  label: 'Your Email',
                  controller: emailController,
                  focusNode: emailFocusNode,
                ),
              ),
              _boxSelectDateAndGender(
                context: context,
                widget: ValueListenableBuilder<DateTime>(
                  valueListenable: selectedDate,
                  builder: (context, value, child) {
                    return Text(
                      !isSelectedDate
                          ? 'What is your date of birth?'
                          : DateFormat.yMd().format(value),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AutilabColor.gray,
                          ),
                    );
                  },
                ),
                icon: 'assets/icons/calendar_tick_icon.svg',
                onTap: () async {
                  //Display dialog for show table calendar

                  showCustomDialog(
                    context,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TableCalendar(
                          currentDay: _focusedDay,
                          focusedDay: _focusedDay ?? DateTime.now(),
                          firstDay: DateTime(1900),
                          lastDay: DateTime(2030),
                          headerVisible: true,
                          calendarStyle: const CalendarStyle(
                            outsideDaysVisible: false,
                          ),
                          availableCalendarFormats: const {
                            CalendarFormat.month: '',
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              //Change isSelectedDate variable for display date
                              isSelectedDate = true;
                              //Initialize _focusedDay variable value with selectedDay
                              _focusedDay = selectedDay;
                              //Initialize selectedDate variable value with _focusedDay
                              selectedDate.value = _focusedDay!;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              _boxSelectDateAndGender(
                context: context,
                widget: Text(
                  selectedGender ?? 'Select your gender',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AutilabColor.gray,
                      ),
                ),
                icon: isDropdownOpen
                    ? 'assets/icons/arrow_up.svg'
                    : 'assets/icons/arrow_down.svg',
                onTap: () {
                  setState(() {
                    isDropdownOpen = !isDropdownOpen;
                  });
                },
              ),
              SliverToBoxAdapter(
                child: Visibility(
                  visible: isDropdownOpen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AutilabColor.bb),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: genderOptions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  genderOptions[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AutilabColor.gray,
                                      ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                selectedGender = genderOptions[index];
                                isDropdownOpen = false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Text(
                        'More Detail About You',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      TextFieldBoxEnterDescription(
                        hintText: 'Enter Your Info Here...',
                        bordeColor: Colors.transparent,
                        borderRadius: 16,
                        maxLine: 4,
                        descriptionController: descriptionController,
                        descriptionFocusNode: descriptionFocusNode,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CustomButtonWidget(
                  onTap: () {},
                  height: 50,
                  width: double.infinity,
                  color: AutilabColor.bb,
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 40),
                  text: 'Update Profile',
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Widget for display box select date of birth & select gender
  Widget _boxSelectDateAndGender({
    required BuildContext context,
    required Widget widget,
    required Function() onTap,
    required String icon,
  }) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.only(left: 10, right: 24),
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xffECF0FF),
          border: Border.all(color: AutilabColor.bb),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget,
            GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
