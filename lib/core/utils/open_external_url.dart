import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openExternalURL(BuildContext context, String urlToOpen) async {
  final Uri url = Uri.parse(urlToOpen);

  final messager = ScaffoldMessenger.of(context);

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    messager
        .showSnackBar(const SnackBar(content: Text('Could not launch url')));
  }
}
