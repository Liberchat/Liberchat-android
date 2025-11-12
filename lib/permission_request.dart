import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> requestAllPermissions(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final hasAsked = prefs.getBool('permissions_asked') ?? false;
  
  if (hasAsked) return;
  
  final shouldRequest = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Permissions nécessaires'),
      content: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Liberchat a besoin des permissions suivantes pour fonctionner correctement :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.mic, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(child: Text('Microphone - Pour les appels vocaux')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.folder, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(child: Text('Stockage - Pour enregistrer et partager des fichiers')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.image, color: Colors.green),
                SizedBox(width: 8),
                Expanded(child: Text('Photos/Vidéos - Pour partager des médias')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.audiotrack, color: Colors.purple),
                SizedBox(width: 8),
                Expanded(child: Text('Audio - Pour partager des fichiers audio')),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Plus tard'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Accepter'),
        ),
      ],
    ),
  );

  if (shouldRequest == true) {
    final permissions = [
      Permission.microphone,
      Permission.storage,
      Permission.photos,
      Permission.videos,
      Permission.audio,
    ];
    
    await permissions.request();
    await prefs.setBool('permissions_asked', true);
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Permissions configurées avec succès'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  } else if (shouldRequest == false) {
    await prefs.setBool('permissions_asked', true);
  }
}
