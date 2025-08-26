//Method for display status NewAppointment card
import 'dart:ui';

import '../../core/constants/color_constant.dart';

(String, String, Color, String) statusCheckColor(String value) {
  String statusIcon = '';
  String statusDescription = '';
  String status = '';

  Color colorStatus = AutilabColor.gray;

  switch (value) {
    case 'PENDING':
      statusIcon = 'assets/icons/minimize_icon.svg';
      status = 'Pending';
      statusDescription = 'Your Appointment Is Being Reviewed';
      colorStatus = AutilabColor.gray;
      break;

    case 'CANCELLED':
      statusIcon = 'assets/icons/close_icon.svg';
      status = 'Cancel';
      statusDescription = 'Your Appointment Has Been Canceled';
      colorStatus = const Color(0xffFF6363);
      break;

    case 'APPROVED':
      statusIcon = 'assets/icons/done_icon.svg';
      status = 'Approved';
      statusDescription = 'Your Appointment Has Been Approved';
      colorStatus = const Color(0xff50DD81);
      break;

    default:
      status = 'Pending';
      colorStatus = AutilabColor.gray;
  }
  return (statusIcon, status, colorStatus, statusDescription);
}
