import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openExternalURL(BuildContext context, String urlToOpen) async {
  final Uri url = Uri.parse(urlToOpen);

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    MonekinSnackbar.error(SnackbarParams.fromError('Could not launch url'));
  }
}
