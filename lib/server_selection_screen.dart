import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> _recentServers = [];
  String? _selectedPreset;

  @override
  void initState() {
    super.initState();
    _loadRecentServers();
    _selectedPreset = _presets.first;
    _controller.text = _selectedPreset!;
  }

  Future<void> _loadRecentServers() async {
    final prefs = await SharedPreferences.getInstance();
    final recent = prefs.getStringList('recent_servers') ?? [];
    setState(() {
      _recentServers = recent;
    });
  }

  Future<void> _saveRecentServer(String url) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recent = prefs.getStringList('recent_servers') ?? [];
    
    // Supprimer l'URL si elle existe déjà
    recent.remove(url);
    // Ajouter en première position
    recent.insert(0, url);
    // Garder seulement les 5 derniers
    if (recent.length > 5) {
      recent = recent.take(5).toList();
    }
    
    await prefs.setStringList('recent_servers', recent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Choisir le serveur Liberchat'),
        ),
        centerTitle: true, // Ajouté pour centrer le titre
        backgroundColor: Colors.black.withOpacity(0.7),
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.red],
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
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
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
                      dropdownColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.red,
                      items: _presets.map((url) => DropdownMenuItem(
                        value: url,
                        child: Text(url, style: const TextStyle(color: Colors.white)),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPreset = value;
                          _controller.text = value!;
                        });
                      },
                    ),
                    if (_recentServers.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Serveurs récents :',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      ...(_recentServers.take(5).map((server) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.text = server;
                              });
                            },
                            child: Text(
                              server.length > 40 ? '${server.substring(0, 40)}...' : server,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      )).toList()),
                    ],
                    const SizedBox(height: 16),
                    TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'URL du serveur',
                        labelStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        helperText: "Vous pouvez saisir l'URL d'un serveur auto-hébergé.",
                        helperStyle: TextStyle(color: Colors.white54),
                        fillColor: Colors.transparent,
                      ),
                      cursorColor: Colors.red,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () async {
                          final url = _controller.text.trim();
                          final uri = Uri.tryParse(url);
                          if (url.isEmpty) return;
                          if (uri == null || !uri.isAbsolute || !(url.startsWith('http://') || url.startsWith('https://'))) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Veuillez saisir une URL valide commençant par http:// ou https://')),
                            );
                            return;
                          }
                          await _saveRecentServer(url);
                          widget.onServerSelected(url);
                        },
                        child: const Text('Continuer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
  }
}
