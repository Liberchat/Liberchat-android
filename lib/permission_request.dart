import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestMicrophonePermission(BuildContext context) async {
  final status = await Permission.microphone.request();
  if (status.isDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Le micro est nécessaire pour utiliser cette fonctionnalité.')),
    );
  }
}

Future<void> requestCameraPermission(BuildContext context) async {
  final status = await Permission.camera.request();
  if (status.isDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La caméra est nécessaire pour utiliser cette fonctionnalité.')),
    );
  }
}

Future<void> requestMediaPermissions(BuildContext context) async {
  // Demander les permissions une par une pour s'assurer qu'elles apparaissent
  await Permission.microphone.request();
  await Permission.camera.request();
}
