import 'package:autilab_project/utils/functions/permissioncotrol.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/widgets/snackbar_widget.dart';
import '../../core/constants/color_constant.dart';

Future<void> openMap(
    BuildContext context, double latitude, double longitude) async {
  if (await isPermissionLocationGranted()) {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  } else {
    // Permission denied: Show error message
    displaySnackBar(
      context,
      'Location access permission denied.',
      AutilabColor.bb,
    );
    return;
  }
}
