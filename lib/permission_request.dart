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
      title: const Text('Required Permissions'),
      content: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Liberchat needs the following permissions to function correctly:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.mic, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(child: Text('Microphone - For voice calls')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.folder, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(child: Text('Storage - To save and share files')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.image, color: Colors.green),
                SizedBox(width: 8),
                Expanded(child: Text('Photos/Videos - To share media')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.audiotrack, color: Colors.purple),
                SizedBox(width: 8),
                Expanded(child: Text('Audio - To share audio files')),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Later'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Accept'),
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
