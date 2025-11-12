import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart';

class ServerSelectionScreen extends StatefulWidget {
  final void Function(String url) onServerSelected;
  const ServerSelectionScreen({super.key, required this.onServerSelected});

  @override
  State<ServerSelectionScreen> createState() => _ServerSelectionScreenState();
}

class _ServerSelectionScreenState extends State<ServerSelectionScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _presets = [
    'https://liberchat.cnt-ait-contact.noho.st/liberchat/'
  ];
  String? _selectedPreset;

  @override
  void initState() {
    super.initState();
    _selectedPreset = _presets.first;
    _controller.text = _selectedPreset!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final backgroundColor = isDark ? Colors.grey[900]! : Colors.grey[50]!;
        final primaryColor = themeManager.primaryColor;
        final fontSize = themeManager.fontSize;
        
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Choisir le serveur Liberchat',
                style: TextStyle(fontSize: fontSize + 2),
              ),
            ),
            centerTitle: true,
            backgroundColor: primaryColor.withOpacity(0.9),
            elevation: 8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      backgroundColor,
                      primaryColor.withOpacity(0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: isDark 
                    ? Colors.grey[800]!.withOpacity(0.9)
                    : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/logo.png', width: 72, height: 72),
                    ),
                    const SizedBox(height: 24),
                    DropdownButton<String>(
                      value: _selectedPreset,
                      dropdownColor: isDark ? Colors.grey[800] : Colors.white,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: fontSize,
                      ),
                      iconEnabledColor: primaryColor,
                      items: _presets.map((url) => DropdownMenuItem(
                        value: url,
                        child: Text(
                          url,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontSize: fontSize,
                          ),
                        ),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPreset = value;
                          _controller.text = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _controller,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: fontSize,
                      ),
                      decoration: InputDecoration(
                        labelText: 'URL du serveur',
                        labelStyle: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54,
                          fontSize: fontSize,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        helperText: "Vous pouvez saisir l'URL d'un serveur auto-hébergé.",
                        helperStyle: TextStyle(
                          color: isDark ? Colors.white54 : Colors.black45,
                          fontSize: fontSize - 2,
                        ),
                        fillColor: Colors.transparent,
                      ),
                      cursorColor: primaryColor,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          final url = _controller.text.trim();
                          final uri = Uri.tryParse(url);
                          if (url.isEmpty) return;
                          if (uri == null || !uri.isAbsolute || !(url.startsWith('http://') || url.startsWith('https://'))) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Veuillez saisir une URL valide commençant par http:// ou https://',
                                  style: TextStyle(fontSize: fontSize),
                                ),
                              ),
                            );
                            return;
                          }
                          widget.onServerSelected(url);
                        },
                        child: Text(
                          'Continuer',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize + 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
            ],
          ),
        );
      },
    );
  }
}
