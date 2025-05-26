import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../message/page/class/message.dart';

class ChatListWhiteboardWidget extends StatelessWidget {
  const ChatListWhiteboardWidget({
    super.key,
    required ScrollController scrollController,
    required this.message,
  }) : _scrollController = scrollController;
  final List<Message> message;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: message.length,
      padding: const EdgeInsets.symmetric(vertical: 35),
      controller: _scrollController,
      itemBuilder: (context, index) {
        //Control background message color
        var color = message[index].userId == '1'
            ? const Color(0xffECF0FF)
            : AutilabColor.bb;
        return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 8),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message[index].message,
            style: AutilabTextStyle.small10_400,
          ),
        );
      },
    );
  }
}
