import 'dart:io';

import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/page/nearby_center_details_screen.dart';
import 'package:autilab_project/features/data/menu/Page/rating_screen.dart';
import 'package:autilab_project/utils/functions/custom_dialog_function.dart';
import 'package:autilab_project/utils/functions/permissioncotrol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/cached_network_image_widget.dart';
import '../../../../common/widgets/snackbar_widget.dart';
import '../../../../common/widgets/textfiledbox_description.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../../../utils/functions/open_location_function.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final ValueNotifier<RadioCharacter> selectedGenderMaleNotifier =
      ValueNotifier<RadioCharacter>(RadioCharacter.characterOne);

  final firstNameController = TextEditingController(text: 'Denis');
  final lasNameController = TextEditingController(text: 'Iliev');
  final emailController = TextEditingController(text: 'denis@gmail.com');
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  final firstNameFocusNode = FocusNode();
  final lasNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  XFile? pickedFile;

  final bool isImage = true;
  bool isSelectedDate = false;

  ValueNotifier<DateTime?> _selectedDate = ValueNotifier(DateTime.now());

  DateTime? tempSelectedDate;

  String dateOfBirth = '';

  final List<String> genderOptions = ['Male', 'Female'];
  String selectedGender = 'Male';
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
  Future<void> pickImage() async {
    final imagePicker = ImagePicker();

    // Show modal bottom sheet to choose image source
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(
                'Gallery',
                style: AutilabTextStyle.medium16_500,
              ),
              onTap: () async {
                try {
                  // Handle gallery image picking with permission
                  if (await isPermissionStorageGranted()) {
                    // If permission already granted, pick image from gallery
                    pickedFile = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (pickedFile?.path == null) {
                      Navigator.pop(context);
                      return;
                    } else {
                      pickedFile = XFile(pickedFile!.path);
                      Navigator.pop(context);
                      setState(() {});
                    }
                  } else {
                    Navigator.pop(context);
                    // Permission denied: Show error message
                    displaySnackBar(
                      context,
                      'Memory access permission denied.',
                      AutilabColor.bb,
                    );
                    return;
                  }
                } catch (e) {
                  Navigator.pop(context);

                  // Catch any unexpected errors and show message
                  displaySnackBar(
                    context,
                    'Error while saving: $e',
                    AutilabColor.bb,
                  );
                  return;
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text(
                'Camera',
                style: AutilabTextStyle.medium16_500,
              ),
              onTap: () async {
                // Handle camera image picking with permission
                if (await isPermissionCameraGranted()) {
                  // If permission already granted, pick image from camera
                  pickedFile =
                      await imagePicker.pickImage(source: ImageSource.camera);

                  try {
                    if (pickedFile?.path == null) {
                      Navigator.pop(context);
                      return;
                    } else {
                      pickedFile = XFile(pickedFile!.path);
                      Navigator.pop(context);
                      setState(() {});
                    }
                  } catch (e) {
                    Navigator.pop(context);

                    // Catch any unexpected errors and show message
                    displaySnackBar(
                      context,
                      'Error while saving: $e',
                      AutilabColor.bb,
                    );
                    return;
                  }
                } else {
                  Navigator.pop(context);

                  // Permission denied: Show error message
                  displaySnackBar(
                    context,
                    'Camera access permission denied.',
                    AutilabColor.bb,
                  );
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isSelectDay(ValueNotifier<DateTime> selectedDat, DateTime day) {
    if (day == selectedDat.value) {
      _selectedDate = ValueNotifier(day);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
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
                                pickImage();
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
                    const Text(
                      'Denis Iliev',
                      style: AutilabTextStyle.medium16_500,
                    ),
                    const Text(
                      'denis@gmail.com',
                      style: AutilabTextStyle.small18_400,
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
                widget: ValueListenableBuilder<DateTime?>(
                  valueListenable: _selectedDate,
                  builder: (context, value, child) {
                    return Text(
                      _selectedDate.value == null
                          ? 'What is your date of birth?'
                          : DateFormat.yMd().format(value ?? DateTime.now()),
                      style: AutilabTextStyle.small14_400.copyWith(
                        color: _selectedDate.value != null
                            ? AutilabColor.black
                            : AutilabColor.gray,
                      ),
                    );
                  },
                ),
                icon: 'assets/icons/calendar_tick_icon.svg',
                onTap: () async {
                  final selectedDate = await showRoundedDatePicker(
                    context: Navigator.of(context, rootNavigator: true).context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                    borderRadius: 16,
                    height: 350,
                    theme: ThemeData(
                      primaryColor: AutilabColor.bb,
                      textTheme: const TextTheme(
                        titleMedium: AutilabTextStyle.small16_400,
                        bodyLarge: AutilabTextStyle.medium14_500,
                        bodyMedium: AutilabTextStyle.medium14_500,
                        bodySmall: AutilabTextStyle.medium14_500,
                      ),
                      colorScheme: const ColorScheme.light(
                        primary: AutilabColor.bb,
                      ),
                    ),
                    onTapDay: (dateTime, available) {
                      tempSelectedDate = dateTime;
                      return true;
                    },
                    textActionButton: "Submit",
                    onTapActionButton: () {
                      _selectedDate.value = tempSelectedDate;
                      context.pop();
                    },
                    textPositiveButton: '',
                    textNegativeButton: '',
                  );

                  if (selectedDate != null) {
                    _selectedDate.value = selectedDate;
                  }
                },
              ),
              _boxSelectDateAndGender(
                context: context,
                widget: Text(
                  selectedGender,
                  style: AutilabTextStyle.small14_400.copyWith(
                    color: AutilabColor.black,
                  ),
                ),
                icon: null,
                onTap: () {
                  selectedGenderMaleNotifier.value = selectedGender == 'Male'
                      ? RadioCharacter.characterOne
                      : RadioCharacter.secondeCharacter;

                  showCustomDialog(
                    context,
                    ValueListenableBuilder(
                      valueListenable: selectedGenderMaleNotifier,
                      builder: (context, value, child) {
                        return Container(
                          constraints: const BoxConstraints(
                              maxWidth: 528, maxHeight: 420),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
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
                                    'Gender',
                                    style: AutilabTextStyle.small18_400,
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
                              RadioButtonWidget(
                                radioCharacter:
                                    selectedGenderMaleNotifier.value,
                                value: RadioCharacter.characterOne,
                                onChanged: (value) {
                                  selectedGenderMaleNotifier.value =
                                      RadioCharacter.characterOne;
                                },
                                title: 'Male',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              RadioButtonWidget(
                                radioCharacter:
                                    selectedGenderMaleNotifier.value,
                                value: RadioCharacter.secondeCharacter,
                                onChanged: (value) {
                                  selectedGenderMaleNotifier.value =
                                      RadioCharacter.secondeCharacter;
                                },
                                title: 'Female',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomButtonWidget(
                                onTap: () {
                                  setState(() {
                                    if (selectedGenderMaleNotifier.value ==
                                        RadioCharacter.characterOne) {
                                      selectedGender = 'Male';
                                    } else {
                                      selectedGender = 'Female';
                                    }
                                  });
                                  context.pop();
                                },
                                height: 50,
                                margin: const EdgeInsets.only(top: 16),
                                color: AutilabColor.bb,
                                text: 'Submit',
                                textStyle: AutilabTextStyle.small18_400,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
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
                                  style: AutilabTextStyle.small14_400.copyWith(
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
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: TitleAndIconWidget(
                    title: 'Address',
                    icon: 'assets/icons/location-tick.svg',
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 48, top: 24),
                sliver: SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      TextFieldBoxEnterDescription(
                        hintText: 'open the map and set your current location',
                        bordeColor: AutilabColor.gray,
                        borderRadius: 16,
                        maxLine: 4,
                        descriptionController: addressController,
                        descriptionFocusNode: addressFocusNode,
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: CustomButtonWidget(
                          onTap: () async {
                            openMap(context, 49.2331, -123.0992);
                          },
                          height: 31,
                          width: 116,
                          margin: EdgeInsets.zero,
                          borderRadius: 8,
                          color: AutilabColor.bb,
                          text: 'Open Map',
                          textStyle: AutilabTextStyle.small12_400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: TitleAndIconWidget(
                    title: 'More Detail About You',
                    icon: 'assets/icons/info-circle.svg',
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 48, top: 24),
                sliver: SliverToBoxAdapter(
                  child: TextFieldBoxEnterDescription(
                    hintText: 'Enter Your Info Here...',
                    bordeColor: AutilabColor.gray,
                    borderRadius: 16,
                    maxLine: 4,
                    descriptionController: descriptionController,
                    descriptionFocusNode: descriptionFocusNode,
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
                  text: 'Save Change',
                  textStyle: AutilabTextStyle.small18_400,
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
    required String? icon,
  }) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => onTap(),
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
              if (icon != null) ...[
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
            ],
          ),
        ),
      ),
    );
  }
}
