import 'dart:io';
import 'dart:ui' as ui;

import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/core/network/locator.dart';
import 'package:autilab_project/features/data/auth/data/model/user_param.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_bloc.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_event.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_state.dart';
import 'package:autilab_project/features/data/doctor/page/nearby_center_details_screen.dart';
import 'package:autilab_project/features/data/menu/Page/rating_screen.dart';
import 'package:autilab_project/presentation/screens/not_connection_screen.dart';
import 'package:autilab_project/utils/functions/custom_dialog_function.dart';
import 'package:autilab_project/utils/functions/permissioncotrol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../common/widgets/cached_network_image_widget.dart';
import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../common/widgets/snackbar_widget.dart';
import '../../../../../common/widgets/textfiledbox_description.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../utils/functions/cacheimahe_function.dart';
import '../../../../../utils/functions/open_location_function.dart';

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

  final firstNameController = TextEditingController();
  final lasNameController = TextEditingController();
  final emailController = TextEditingController();
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
  String finalDate = '';
  final List<String> genderOptions = ['Male', 'Female'];
  String selectedGender = 'male';
  bool isDropdownOpen = false;
  @override
  void initState() {
    BlocProvider.of<AuthenticationBloc>(context).add(DisplayInformationUser());

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
  Future<void> pickImage(
    final bool isMobile,
  ) async {
    final imagePicker = ImagePicker();

    // Show modal bottom sheet to choose image source
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(
                'Gallery',
                style: AutilabTextStyle.medium16_500
                    .copyWith(fontSize: isMobile ? 16 : 18),
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
              title: Text(
                'Camera',
                style: AutilabTextStyle.medium16_500
                    .copyWith(fontSize: isMobile ? 16 : 18),
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
            child: BlocProvider(
              create: (context) => AuthenticationBloc(locator.get())
                ..add(DisplayInformationUser()),
              child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is FetchUserDataResponse) {
                    return state.response.fold(
                      (l) {},
                      (response) {
                        firstNameController.text = response.firstName;
                        lasNameController.text = response.lastName;
                        emailController.text = response.email;
                        String date = response.birthdate;
                        addressController.text = response.address;
                        descriptionController.text = response.description;
                        String datePart = date.split('T')[0];
                        selectedGender = response.gender == "not_given"
                            ? 'Select your gender'
                            : response.gender;
                        finalDate = datePart.replaceAll('-', '/');
                        finalDate = response.birthdate == ''
                            ? 'What is your date of birth?'
                            : response.birthdate;
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthenticationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AutilabColor.bb,
                      ),
                    );
                  }
                  if (state is AuthenticationError) {
                    return NotConnectionInternetScreen(
                      onChange: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(DisplayInformationUser());
                      },
                    );
                  }
                  if (state is FetchUserDataResponse) {
                    return state.response.fold(
                      (error) {
                        return NotConnectionInternetScreen(
                          onChange: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(DisplayInformationUser());
                          },
                        );
                      },
                      (response) {
                        return Scaffold(
                          body: SafeArea(
                            child: CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: isMobile() ? 104 : 168,
                                        height: isMobile() ? 104 : 168,
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                        child: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachednetworkimageWidget(
                                                imgUrl: response.photo,
                                                img: pickedFile?.path != null
                                                    ? Image.file(
                                                        File(pickedFile!.path),
                                                        fit: BoxFit.cover,
                                                        width: isMobile()
                                                            ? 104
                                                            : 168,
                                                        height: isMobile()
                                                            ? 104
                                                            : 168,
                                                        cacheWidth:
                                                            cacheImageFunction(
                                                                isMobile()
                                                                    ? 104
                                                                    : 168,
                                                                context),
                                                        cacheHeight:
                                                            cacheImageFunction(
                                                                isMobile()
                                                                    ? 104
                                                                    : 168,
                                                                context),
                                                      )
                                                    : Image.asset(
                                                        'assets/images/avatar.png',
                                                        fit: BoxFit.cover,
                                                        width: isMobile()
                                                            ? 104
                                                            : 168,
                                                        height: isMobile()
                                                            ? 104
                                                            : 168,
                                                        cacheWidth:
                                                            cacheImageFunction(
                                                                isMobile()
                                                                    ? 104
                                                                    : 168,
                                                                context),
                                                        cacheHeight:
                                                            cacheImageFunction(
                                                                isMobile()
                                                                    ? 104
                                                                    : 168,
                                                                context),
                                                      ),
                                                isNetworkImage:
                                                    response.photo != ''
                                                        ? true
                                                        : false,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: isMobile() ? 8 : 16,
                                              child: GestureDetector(
                                                onTap: () {
                                                  pickImage(
                                                    isMobile(),
                                                  );
                                                },
                                                child: Container(
                                                  width: isMobile() ? 30 : 36,
                                                  height: isMobile() ? 30 : 36,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AutilabColor.bb,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/camera.svg',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${response.firstName} ${response.lastName}',
                                        style: AutilabTextStyle.medium16_500
                                            .copyWith(
                                          fontSize: isMobile() ? 16 : 28,
                                        ),
                                      ),
                                      Text(
                                        response.email,
                                        style: AutilabTextStyle.small18_400
                                            .copyWith(
                                          fontSize: isMobile() ? 18 : 20,
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
                                    isMobile: isMobile(),
                                    textInputAction: TextInputAction.next,
                                    borderColor: AutilabColor.bb,
                                    textStyle:
                                        AutilabTextStyle.small14_400.copyWith(
                                      color: AutilabColor.black,
                                      fontSize: isMobile() ? 14 : 20,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    borderRaduis: isMobile() ? 16 : 24,
                                    backgroundColor: const Color(0xffECF0FF),
                                    lblColor: AutilabColor.gray,
                                    label: 'What’s your first name?',
                                    controller: firstNameController,
                                    focusNode: firstNameFocusNode,
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: CustomTextfield(
                                    isMobile: isMobile(),
                                    textInputAction: TextInputAction.next,
                                    borderColor: AutilabColor.bb,
                                    textStyle:
                                        AutilabTextStyle.small14_400.copyWith(
                                      color: AutilabColor.black,
                                      fontSize: isMobile() ? 14 : 20,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    borderRaduis: isMobile() ? 16 : 24,
                                    backgroundColor: const Color(0xffECF0FF),
                                    lblColor: AutilabColor.gray,
                                    label: 'And your last name?',
                                    controller: lasNameController,
                                    focusNode: lasNameFocusNode,
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: CustomTextfield(
                                    isMobile: isMobile(),
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.emailAddress,
                                    borderColor: AutilabColor.bb,
                                    textStyle:
                                        AutilabTextStyle.small14_400.copyWith(
                                      color: AutilabColor.black,
                                      fontSize: isMobile() ? 14 : 20,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    borderRaduis: isMobile() ? 16 : 24,
                                    backgroundColor: const Color(0xffECF0FF),
                                    lblColor: AutilabColor.gray,
                                    label: 'Your Email',
                                    controller: emailController,
                                    focusNode: emailFocusNode,
                                  ),
                                ),
                                _boxSelectDateAndGender(
                                  isMobile: isMobile(),
                                  context: context,
                                  widget: ValueListenableBuilder<DateTime?>(
                                    valueListenable: _selectedDate,
                                    builder: (context, value, child) {
                                      return Text(
                                        isSelectedDate
                                            ? DateFormat('yyyy/MM/dd')
                                                .format(tempSelectedDate!)
                                            : finalDate,
                                        style: AutilabTextStyle.small14_400
                                            .copyWith(
                                          color: _selectedDate.value != null &&
                                                  isSelectedDate
                                              ? AutilabColor.black
                                              : AutilabColor.gray,
                                          fontSize: isMobile() ? 14 : 20,
                                        ),
                                      );
                                    },
                                  ),
                                  icon: 'assets/icons/calendar_tick_icon.svg',
                                  onTap: () async {
                                    final selectedDate =
                                        await showRoundedDatePicker(
                                      context: Navigator.of(context,
                                              rootNavigator: true)
                                          .context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                      borderRadius: 16,
                                      height: 350,
                                      theme: ThemeData(
                                        primaryColor: AutilabColor.bb,
                                        textButtonTheme: TextButtonThemeData(
                                          style: ButtonStyle(
                                            textStyle: WidgetStatePropertyAll(
                                              AutilabTextStyle.medium24_500
                                                  .copyWith(
                                                fontSize: isMobile() ? 14 : 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                        textTheme: TextTheme(
                                          titleMedium: AutilabTextStyle
                                              .small16_400
                                              .copyWith(
                                            fontSize: isMobile() ? 16 : 20,
                                          ),
                                          bodyLarge:
                                              AutilabTextStyle.medium14_500,
                                          bodyMedium: AutilabTextStyle
                                              .medium24_500
                                              .copyWith(
                                            fontSize: isMobile() ? 14 : 20,
                                          ),
                                          bodySmall:
                                              AutilabTextStyle.medium14_500,
                                        ),
                                        colorScheme: const ColorScheme.light(
                                          primary: AutilabColor.bb,
                                        ),
                                      ),
                                      onTapDay: (dateTime, available) {
                                        tempSelectedDate = dateTime;
                                        return true;
                                      },
                                      textDirection: ui.TextDirection.rtl,
                                      textActionButton: "Submit",
                                      onTapActionButton: () {
                                        if (tempSelectedDate == null) {
                                          context.pop();

                                          return;
                                        } else {
                                          _selectedDate.value =
                                              tempSelectedDate;
                                          setState(() {
                                            isSelectedDate = true;
                                          });
                                        }

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
                                  isMobile: isMobile(),
                                  context: context,
                                  widget: Text(
                                    selectedGender,
                                    style:
                                        AutilabTextStyle.small14_400.copyWith(
                                      color:
                                          selectedGender == 'Select your gender'
                                              ? AutilabColor.gray
                                              : AutilabColor.black,
                                      fontSize: isMobile() ? 14 : 20,
                                    ),
                                  ),
                                  icon: null,
                                  onTap: () {
                                    selectedGenderMaleNotifier.value =
                                        selectedGender == 'male'
                                            ? RadioCharacter.characterOne
                                            : RadioCharacter.secondeCharacter;

                                    showCustomDialog(
                                      context,
                                      ValueListenableBuilder(
                                        valueListenable:
                                            selectedGenderMaleNotifier,
                                        builder: (context, value, child) {
                                          return Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 528, maxHeight: 420),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 16),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                      child: const Icon(
                                                          Icons.close_rounded),
                                                    ),
                                                    Text(
                                                      'Gender',
                                                      style: AutilabTextStyle
                                                          .medium18_500
                                                          .copyWith(
                                                        fontSize: isMobile()
                                                            ? 18
                                                            : 20,
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
                                                RadioButtonWidget(
                                                  isMobile: isMobile(),
                                                  textStyle: AutilabTextStyle
                                                      .small14_400
                                                      .copyWith(
                                                    fontSize:
                                                        isMobile() ? 14 : 18,
                                                  ),
                                                  radioCharacter:
                                                      selectedGenderMaleNotifier
                                                          .value,
                                                  value: RadioCharacter
                                                      .characterOne,
                                                  onChanged: (value) {
                                                    selectedGenderMaleNotifier
                                                            .value =
                                                        RadioCharacter
                                                            .characterOne;
                                                  },
                                                  title: 'Male',
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                RadioButtonWidget(
                                                  isMobile: isMobile(),
                                                  radioCharacter:
                                                      selectedGenderMaleNotifier
                                                          .value,
                                                  value: RadioCharacter
                                                      .secondeCharacter,
                                                  onChanged: (value) {
                                                    selectedGenderMaleNotifier
                                                            .value =
                                                        RadioCharacter
                                                            .secondeCharacter;
                                                  },
                                                  title: 'Female',
                                                  textStyle: AutilabTextStyle
                                                      .small14_400
                                                      .copyWith(
                                                    fontSize:
                                                        isMobile() ? 14 : 18,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                CustomButtonWidget(
                                                  isMobile: isMobile(),
                                                  onTap: () {
                                                    setState(() {
                                                      if (selectedGenderMaleNotifier
                                                              .value ==
                                                          RadioCharacter
                                                              .characterOne) {
                                                        selectedGenderMaleNotifier
                                                                .value ==
                                                            RadioCharacter
                                                                .characterOne;
                                                        selectedGender = 'male';
                                                      } else {
                                                        selectedGender =
                                                            'female';
                                                      }
                                                    });
                                                    context.pop();
                                                  },
                                                  height: 50,
                                                  margin: const EdgeInsets.only(
                                                      top: 16),
                                                  color: AutilabColor.bb,
                                                  text: 'Submit',
                                                  textStyle: AutilabTextStyle
                                                      .small18_400,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AutilabColor.bb),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: genderOptions.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    genderOptions[index],
                                                    style: AutilabTextStyle
                                                        .small14_400
                                                        .copyWith(
                                                      color: AutilabColor.gray,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedGender =
                                                      genderOptions[index];
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
                                SliverPadding(
                                  padding: AutilabMargin.marginFullScreen,
                                  sliver: SliverToBoxAdapter(
                                    child: TitleAndIconWidget(
                                      isMobile: isMobile(),
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
                                          textStyle: AutilabTextStyle
                                              .small14_400
                                              .copyWith(
                                            fontSize: isMobile() ? 14 : 24,
                                          ),
                                          hintText:
                                              'open the map and set your current location',
                                          bordeColor: AutilabColor.gray,
                                          borderRadius: isMobile() ? 16 : 24,
                                          maxLine: 4,
                                          descriptionController:
                                              addressController,
                                          descriptionFocusNode:
                                              addressFocusNode,
                                        ),
                                        Positioned(
                                          right: 16,
                                          bottom: 16,
                                          child: CustomButtonWidget(
                                            onTap: () async {
                                              openMap(
                                                  context, 49.2331, -123.0992);
                                            },
                                            height: 31,
                                            width: 116,
                                            margin: EdgeInsets.zero,
                                            borderRadius: 8,
                                            color: AutilabColor.bb,
                                            text: 'Open Map',
                                            textStyle:
                                                AutilabTextStyle.small12_400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SliverPadding(
                                  padding: AutilabMargin.marginFullScreen,
                                  sliver: SliverToBoxAdapter(
                                    child: TitleAndIconWidget(
                                      isMobile: isMobile(),
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
                                      textStyle:
                                          AutilabTextStyle.small14_400.copyWith(
                                        fontSize: isMobile() ? 14 : 24,
                                      ),
                                      hintText: 'Enter Your Info Here...',
                                      bordeColor: AutilabColor.gray,
                                      borderRadius: isMobile() ? 16 : 24,
                                      maxLine: 4,
                                      descriptionController:
                                          descriptionController,
                                      descriptionFocusNode:
                                          descriptionFocusNode,
                                    ),
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: CustomButtonWidget(
                                    isMobile: isMobile(),
                                    onTap: () {
                                      print(tempSelectedDate);
                                      //call UpdateUserProfile Event to edit profile user
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(
                                        UpdateUserProfile(
                                          userParam: UserParam(
                                            email: emailController.text,
                                            firstName: firstNameController.text,
                                            lastName: lasNameController.text,
                                            birthDate: DateFormat('yyyy-MM-dd')
                                                .format(tempSelectedDate ??
                                                    DateTime.now()),
                                            // gender: selectedGender ==
                                            //         'Select your gender'
                                            //     ? "not_given"
                                            //     : selectedGender,
                                            gender: selectedGender,
                                            address: addressController.text,
                                            description:
                                                descriptionController.text,
                                            // photo: File(pickedFile!.path),
                                          ),
                                        ),
                                      );
                                    },
                                    height: 50,
                                    width: double.infinity,
                                    color: AutilabColor.bb,
                                    margin: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 40),
                                    text: 'Save Change',
                                    textStyle: AutilabTextStyle.small18_400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        );
      },
    );
  }

//Widget for display box select date of birth & select gender
  Widget _boxSelectDateAndGender({
    required bool isMobile,
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
          height: isMobile ? 50 : 68,
          decoration: BoxDecoration(
            color: const Color(0xffECF0FF),
            border: Border.all(color: AutilabColor.bb),
            borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
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
                    width: isMobile ? 20 : 24,
                    height: isMobile ? 20 : 24,
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
