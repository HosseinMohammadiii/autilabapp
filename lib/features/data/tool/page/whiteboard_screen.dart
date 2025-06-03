import 'dart:io';
import 'dart:ui' as ui;

import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/icon_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/drawer_box_widget.dart';
import 'package:autilab_project/features/data/message/page/class/message.dart';
import 'package:autilab_project/features/data/tool/page/whiteboardwork_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/widgets/snackbar_widget.dart';
import '../../../../utils/functions/animation_control.dart';
import '../model/whiteboard/drawing_tool.dart';
import '../widgets/boxwhiteboard_widget.dart';
import '../widgets/chatlistwhiteboard_widget.dart';
import '../widgets/custombuttonwhitboard_widget.dart';
import '../widgets/settingmenuwhiteboard_widget.dart';

class WhiteboardScreen extends StatefulWidget {
  const WhiteboardScreen({super.key});

  @override
  State<WhiteboardScreen> createState() => _WhiteboardScreenState();
}

class _WhiteboardScreenState extends State<WhiteboardScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  final ScrollController _scrollController = ScrollController();

  final sendMessageController = TextEditingController();
  final sendMessageFocusNode = FocusNode();
  Color strokeColor = AutilabColor.black;

  final ValueNotifier<StrokeType> strokeType = ValueNotifier(StrokeType.normal);

  //Menu list
  List<DrawerItemClass> settingItems = [
    DrawerItemClass(
      'Full Screen',
      'maximize.svg',
      const Color(0xffDADB88),
    ),
    DrawerItemClass(
      'Manage File',
      'folder.svg',
      const Color(0xffAFDB88),
    ),
    DrawerItemClass(
      'Security',
      'security.svg',
      const Color(0xff88A4DB),
    ),
    DrawerItemClass(
      'Record Screen',
      'maximize.svg',
      const Color(0xff88DBD5),
    ),
    DrawerItemClass(
      'Help',
      'maximize.svg',
      const Color(0xffDB88D5),
    ),
    DrawerItemClass(
      'Screen Setting',
      'maximize.svg',
      const Color(0xffE5898A),
    ),
  ];

  //Paiting tools
  List<String> drawTools = [
    'undo.svg',
    'redo.svg',
    'brush_draw.svg',
    'text.svg',
    'crop.svg',
    'eraser.svg',
    'shapes.svg',
    'trash.svg',
  ];
  //Paiting colors
  List<Color> drawColor = [
    AutilabColor.black,
    const Color(0xff1D2DBD),
    const Color(0xffDE372B),
    const Color(0xffFFFFFF),
  ];
  //Message item
  List<Message> messageItems = [
    Message(
        "That's perfect. There's a new place on Main St I've been wanting There's a new place?",
        '1'),
    Message("That's perfect. There's a new place on Main St I've been wanting.",
        '2'),
    Message("That's perfect. There's a new place on Main St I've been wanting?",
        '1'),
    Message("That's perfect. There's a newe!", '2'),
  ];
  bool isShowMenu = false;
  bool isShowChat = false;
  bool isUpload = false;

  File? image;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
//Scroll to the last message after the textfield focus.
    sendMessageFocusNode.addListener(() {
      if (sendMessageFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToEnd();
        });
      }
    });

//Scroll to the last item after the page is created.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

  //Method for scroll to latest item
  void _scrollToEnd() {
    if (_scrollController.hasClients || isShowChat) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    animationHelper.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    sendMessageFocusNode.removeListener(_scrollToEnd);
    sendMessageFocusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WhiteboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  void _saveDrawing() async {
    try {
      // Step 1: Request permission based on platform and Android version
      bool permissionGranted = false;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;

        if (androidInfo.version.sdkInt >= 33) {
          // Android 13 (API 33) and above: Request access to photos
          final status = await Permission.photos.request();
          permissionGranted = status.isGranted;
        } else {
          // Android below 13: Request storage access
          final status = await Permission.storage.request();
          permissionGranted = status.isGranted;
        }
      } else {
        // iOS or other platforms: Request storage permission
        final status = await Permission.storage.request();
        permissionGranted = status.isGranted;
      }

      // Step 2: If permission is granted, capture the image from RepaintBoundary
      if (permissionGranted) {
        RenderRepaintBoundary boundary =
            key.currentContext!.findRenderObject() as RenderRepaintBoundary;

        // Convert the boundary to image
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);

        // Convert image to PNG byte data
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);

        if (byteData != null) {
          // Step 3: Save image to external storage
          Uint8List pngBytes = byteData.buffer.asUint8List();
          final directory = await getExternalStorageDirectory();
          String filePath =
              '${directory!.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';

          File file = File(filePath);
          await file.writeAsBytes(pngBytes);

          // Show success message
          displaySnackBar(
            context,
            'Image saved in gallery:\n$filePath',
            AutilabColor.bb,
          );
        }
      } else {
        // Permission denied: Show error message
        displaySnackBar(
          context,
          'Memory access permission denied.',
          AutilabColor.bb,
        );
      }
    } catch (e) {
      // Catch any unexpected errors and show message
      displaySnackBar(
        context,
        'Error while saving: $e',
        AutilabColor.bb,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              spacing: 17,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 8,
                      children: [
                        Row(
                          spacing: 4,
                          children: [
                            GestureDetector(
                              onTap: () {
                                //control for display setting menu
                                setState(() {
                                  isShowMenu = !isShowMenu;
                                });
                              },
                              child: Row(
                                children: [
                                  const Text(
                                    'Setting',
                                    style: AutilabTextStyle.small12_400,
                                  ),
                                  isShowMenu
                                      ? SvgPicture.asset(
                                          'assets/icons/arrow_up.svg',
                                          width: 16,
                                          height: 16,
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/arrow_down.svg',
                                        ),
                                ],
                              ),
                            ),
                            CustomButtonWhiteBoardWidget(
                              onTap: () {
                                context.pop();
                              },
                              width: 81,
                              height: 24,
                              color: const Color(0xffE74747),
                              icon: 'logout.svg',
                              title: 'End',
                            ),
                          ],
                        ),
                        CustomButtonWhiteBoardWidget(
                          onTap: () {
                            setState(() {
                              isShowChat = !isShowChat;
                              //Scrolling to last chat list items
                              Future.delayed(const Duration(milliseconds: 50),
                                  () {
                                _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent);
                              });
                            });
                          },
                          width: 150,
                          height: 30,
                          color: AutilabColor.yellow,
                          icon: 'messages.svg',
                          title: 'Chat',
                        ),
                        BoxWhiteBoardWidget(
                          onTapOne: () {
                            //Call method for drawing download
                            _saveDrawing();
                          },
                          colorOne: AutilabColor.lightGray,
                          iconOne: 'download.svg',
                          titleOne: 'Download',
                          onTapSecond: () async {
                            setState(() {
                              isUpload = true;
                            });
                            try {
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedFile?.path == null) {
                                return;
                              } else {
                                image = File(pickedFile!.path);
                                setState(() {});
                              }
                            } catch (e) {
                              print("error: $e");
                            }
                          },
                          colorSecond: isUpload
                              ? AutilabColor.bb
                              : AutilabColor.lightGray,
                          iconSecond: 'upload.svg',
                          titleSecond: 'Upload File',
                        ),
                        BoxWhiteBoardWidget(
                          onTapOne: () {},
                          colorOne: AutilabColor.bb,
                          iconOne: 'video_call_icon.svg',
                          titleOne: 'Webcam',
                          onTapSecond: () {
                            setState(() {
                              isUpload = false;
                            });
                          },
                          colorSecond: !isUpload
                              ? AutilabColor.bb
                              : AutilabColor.lightGray,
                          iconSecond: 'brush.svg',
                          titleSecond: 'Whiteboard',
                        ),
                        BoxWhiteBoardWidget(
                          onTapOne: () {},
                          colorOne: AutilabColor.lightGray,
                          iconOne: 'screenmirroring.svg',
                          titleOne: 'Share Screen',
                          onTapSecond: () {},
                          colorSecond: AutilabColor.bb,
                          iconSecond: 'microphone.svg',
                          titleSecond: 'Voice',
                        ),
                        Expanded(
                          child: Row(
                            spacing: 8,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/doctor_image.png',
                                  fit: BoxFit.cover,
                                  width: 72,
                                  height: 83,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/child2_image.jpg',
                                  fit: BoxFit.cover,
                                  width: 72,
                                  height: 83,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isShowChat,
                      child: Container(
                        width: 241,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AutilabColor.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ChatListWhiteboardWidget(
                              scrollController: _scrollController,
                              message: messageItems,
                            ),
                            Container(
                              width: double.infinity,
                              color: AutilabColor.primary,
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                spacing: 7,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 32,
                                      child: TextField(
                                        focusNode: sendMessageFocusNode,
                                        controller: sendMessageController,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          fillColor: AutilabColor.white,
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 5),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AutilabColor.bb,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AutilabColor.bb,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        onChanged: (value) {},
                                        onTapOutside: (event) {
                                          //Unfocus TextField
                                          sendMessageFocusNode.unfocus();
                                        },
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: AutilabColor.bb,
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                          AutilabIcon.sendMessageIcon),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 30,
                                width: 221,
                                color: AutilabColor.primary,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isShowChat = false;
                                        });
                                      },
                                      child: Row(
                                        spacing: 8,
                                        children: [
                                          SvgPicture.asset(
                                            AutilabIcon.backIconRounded,
                                            width: 16,
                                            height: 16,
                                          ),
                                          const Text(
                                            'Chatroom',
                                            style:
                                                AutilabTextStyle.medium12_500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      'assets/icons/profile_icon.svg',
                                      width: 16,
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isShowMenu,
                      child: SettingMenuWidget(settingItems: settingItems),
                    ),
                  ],
                ),
                Expanded(
                  child: WhiteboardWorkScreen(
                    selectedColor: ValueNotifier(strokeColor),
                    strokeType: ValueNotifier(strokeType.value),
                    isUpload: isUpload,
                    image: image,
                    onChanged: () {},
                  ),
                ),
                FittedBox(
                  child: Container(
                    width: 40,
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: AutilabColor.bb,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: drawTools.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GestureDetector(
                                onTap: () {
                                  // Control for selecting the drawing tool
                                  setState(() {
                                    switch (index) {
                                      case 0:
                                        strokeType.value = StrokeType.undo;
                                        break;
                                      case 1:
                                        strokeType.value = StrokeType.redo;
                                        break;
                                      case 2:
                                        strokeType.value = StrokeType.normal;
                                        break;
                                      case 3:
                                        strokeType.value = StrokeType.text;
                                        break;
                                      case 5:
                                        strokeType.value = StrokeType.eraser;
                                        break;
                                      case 6:
                                        strokeType.value = StrokeType.circle;
                                        break;
                                      case 7:
                                        strokeType.value = StrokeType.deleteAll;
                                        break;

                                      default:
                                        strokeType.value = StrokeType.normal;
                                        break;
                                    }
                                  });
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/${drawTools[index]}',
                                ),
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: drawColor.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  //Initialize strokeColor with drawColor item
                                  strokeColor = drawColor[index];

                                  // Control for selecting the brush tool when using it after deleting all drawings
                                  if (strokeType.value ==
                                      StrokeType.deleteAll) {
                                    strokeType.value = StrokeType.normal;
                                  }
                                });
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                margin: EdgeInsets.only(
                                    bottom:
                                        drawColor.length - 1 == index ? 0 : 8),
                                decoration: BoxDecoration(
                                  color: drawColor[index],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
