import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'permission_request.dart';
import 'server_selection_screen.dart';
import 'orbot_check.dart';
import 'orbot_help_dialog.dart';
import 'error_handler.dart';
import 'theme_manager.dart';
import 'settings_screen.dart';
import 'webview_theme_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser la gestion d'erreurs
  ErrorHandler.initialize();
  
  // Initialiser le gestionnaire de thèmes
  final themeManager = ThemeManager();
  await themeManager.loadSettings();
  
  // Capturer les erreurs non gérées
  runZonedGuarded(() {
    runApp(MyApp(themeManager: themeManager));
  }, (error, stackTrace) {
    debugPrint('Erreur non gérée: $error');
    debugPrint('Stack trace: $stackTrace');
  });
}

class MyApp extends StatelessWidget {
  final ThemeManager themeManager;
  
  const MyApp({super.key, required this.themeManager});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: themeManager,
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Liberchat',
            theme: themeManager.getLightTheme(),
            darkTheme: themeManager.getDarkTheme(),
            themeMode: themeManager.getThemeMode(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String? _selectedUrl;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _tryAutoConnect();
  }

  Future<void> _tryAutoConnect() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUrl = prefs.getString('last_server_url');
    if (lastUrl != null && lastUrl.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LiberchatWebView(serverUrl: lastUrl),
        ),
      );
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        _showServerSelection();
      });
    }
  }

  void _showServerSelection() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServerSelectionScreen(
          onServerSelected: (url) async {
            setState(() => _selectedUrl = url);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('last_server_url', url);
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LiberchatWebView(serverUrl: url),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showChangeServerDialog() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_server_url');
    _showServerSelection();
  }

  Widget _buildLogo() {
    try {
      return Image.asset(
        'assets/logo.png',
        width: 120,
        height: 120,
        errorBuilder: (context, error, stackTrace) {
          return ErrorHandler.buildFallbackLogo(size: 120);
        },
      );
    } catch (e) {
      return ErrorHandler.buildFallbackLogo(size: 120);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final backgroundColor = isDark ? Colors.grey[900]! : Colors.grey[50]!;
        final primaryColor = themeManager.primaryColor;
        
        return Scaffold(
          backgroundColor: backgroundColor,
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
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isDark 
                        ? Colors.grey[800]!.withOpacity(0.3)
                        : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildLogo(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'LIBERCHAT',
                    style: TextStyle(
                      color: isDark ? Colors.white : primaryColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: isDark ? Colors.black : Colors.white,
                          blurRadius: 8,
                          offset: const Offset(2, 2),
                        ),
                        Shadow(
                          color: isDark ? primaryColor : Colors.black26,
                          blurRadius: 16,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CircularProgressIndicator(color: primaryColor),
                ],
              ),
            ),
          ),
          Positioned(
            top: 32,
            right: 24,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Changer de serveur'),
              onPressed: _showChangeServerDialog,
            ),
          ),
            ],
          ),
        );
      },
    );
  }
}

class LiberchatWebView extends StatefulWidget {
  final String serverUrl;
  const LiberchatWebView({super.key, required this.serverUrl});

  @override
  State<LiberchatWebView> createState() => _LiberchatWebViewState();
}

class _LiberchatWebViewState extends State<LiberchatWebView> {
  InAppWebViewController? _webViewController;
  bool _isLoading = true;
  bool _useTor = false; // Ajout du mode Tor
  bool _checkingOrbot = false;

  @override
  void initState() {
    super.initState();
    _loadTorState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestAllPermissions(context);
    });
  }

  Future<void> _loadTorState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _useTor = prefs.getBool('use_tor') ?? false;
    });
  }

  Future<void> _saveTorState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('use_tor', value);
  }

  Future<void> _toggleTor() async {
    if (!_useTor) {
      setState(() => _checkingOrbot = true);
      final running = await isOrbotRunning();
      setState(() => _checkingOrbot = false);
      if (!running) {
        showOrbotHelpDialog(context);
        return;
      }
    }
    setState(() {
      _useTor = !_useTor;
    });
    _saveTorState(!_useTor ? false : true);
  }

  Widget _buildAppBarLogo() {
    try {
      return Image.asset(
        'assets/logo.png', 
        width: 36, 
        height: 36,
        errorBuilder: (context, error, stackTrace) {
          return ErrorHandler.buildFallbackLogo(size: 36);
        },
      );
    } catch (e) {
      return ErrorHandler.buildFallbackLogo(size: 36);
    }
  }

  Future<void> _applyTheme() async {
    if (_webViewController != null) {
      final themeManager = Provider.of<ThemeManager>(context, listen: false);
      await WebViewThemeInjector.injectTheme(_webViewController!, themeManager, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        // Réappliquer le thème quand il change
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _applyTheme();
        });
        
        return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: AppBar(
          backgroundColor: themeManager.primaryColor.withOpacity(0.9),
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _buildAppBarLogo(),
              ),
              const SizedBox(width: 12),
              const Text(
                'Liberchat Mobile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.swap_horiz),
              tooltip: 'Changer de serveur',
              onPressed: () async {
                final url = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServerSelectionScreen(
                      onServerSelected: (url) {
                        Navigator.pop(context, url);
                      },
                    ),
                  ),
                );
                if (url != null && url.isNotEmpty && url != widget.serverUrl) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LiberchatWebView(serverUrl: url),
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Paramètres',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
            PopupMenuButton<int>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      const Icon(Icons.open_in_new, color: Colors.black),
                      const SizedBox(width: 8),
                      const Text('Ouvrir dans le navigateur'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: _isLoading ? Colors.red : Colors.green, size: 18),
                      const SizedBox(width: 8),
                      Text(_isLoading ? 'Déconnecté/chargement' : 'Connecté'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      Icon(_useTor ? Icons.shield : Icons.shield_outlined, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(_useTor ? 'Désactiver Tor' : 'Activer Tor'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) async {
                if (value == 1) {
                  String? url;
                  if (_webViewController != null) {
                    url = (await _webViewController?.getUrl())?.toString();
                  }
                  url ??= widget.serverUrl;
                  if (url.isNotEmpty) {
                    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('URL non disponible.')),
                    );
                  }
                } else if (value == 3) {
                  if (!_checkingOrbot) {
                    _toggleTor();
                  }
                }
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeManager.primaryColor.withOpacity(0.8),
                  themeManager.primaryColor.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(widget.serverUrl),
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() => _isLoading = true);
              },
              onLoadStop: (controller, url) async {
                setState(() => _isLoading = false);
                debugPrint('WebView loaded: $url');
                
                // Injecter le thème après le chargement de la page
                final themeManager = Provider.of<ThemeManager>(context, listen: false);
                await WebViewThemeInjector.injectTheme(controller, themeManager, context);
              },
              onLoadError: (controller, url, code, message) {
                debugPrint('WebView error: $code - $message for URL: $url');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erreur de chargement: $message'),
                    action: SnackBarAction(
                      label: 'Réessayer',
                      onPressed: () => controller.reload(),
                    ),
                  ),
                );
              },
              onLoadHttpError: (controller, url, statusCode, description) {
                debugPrint('WebView HTTP error: $statusCode - $description for URL: $url');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erreur HTTP $statusCode: $description'),
                    action: SnackBarAction(
                      label: 'Réessayer',
                      onPressed: () => controller.reload(),
                    ),
                  ),
                );
              },
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                  mediaPlaybackRequiresUserGesture: false,
                  javaScriptEnabled: true,
                  clearCache: false,
                  cacheEnabled: true,
                  userAgent: 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36',
                ),
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true,
                  mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_COMPATIBILITY_MODE,
                  allowContentAccess: true,
                  allowFileAccess: true,
                  supportMultipleWindows: false,
                ),
              ),
              androidOnPermissionRequest: (controller, origin, resources) async {
                // N'accorder que la permission micro
                if (resources.contains('android.webkit.resource.AUDIO_CAPTURE')) {
                  return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Seule la permission micro est autorisée.')),
                  );
                  return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.DENY,
                  );
                }
              },
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          if (_checkingOrbot)
            const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            ),
        ],
      ),
        );
      },
    );
  }
}
