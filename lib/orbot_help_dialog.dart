import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showOrbotHelpDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Orbot not detected'),
      content: const Text(
        'Tor mode requires Orbot.\n\nPlease start Orbot (or enable Tor proxy) on your device, then try again.\n\nOrbot is available for free on Google Play and F-Droid.',
      ),
      actions: [
        TextButton(
          onPressed: () async {
            const orbotPlay = 'https://play.google.com/store/apps/details?id=org.torproject.android';
            const orbotFdroid = 'https://f-droid.org/packages/org.torproject.android/';
            final url = await canLaunchUrl(Uri.parse(orbotPlay)) ? orbotPlay : orbotFdroid;
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          },
          child: const Text('Install Orbot'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
