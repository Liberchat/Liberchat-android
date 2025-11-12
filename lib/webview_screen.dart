import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'permission_request.dart';

const String kWebviewUrl = 'https://liberchat-3-0-1.onrender.com/';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  InAppWebViewController? _webViewController;
  bool _isLoading = true;
  bool _useExternalBrowser = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestMicrophonePermission(context);
    });
  }

  Future<void> _openInExternalBrowser() async {
    try {
      await launch(
        kWebviewUrl,
        customTabsOption: CustomTabsOption(
          enableUrlBarHiding: true,
          showPageTitle: false,
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: Color(0xFFB71C1C),
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // Fallback vers url_launcher si flutter_custom_tabs échoue
      try {
        await launchUrl(Uri.parse(kWebviewUrl), mode: LaunchMode.externalApplication);
      } catch (e2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Impossible d\'ouvrir le navigateur externe.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB71C1C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Liberchat', style: TextStyle(color: Colors.white)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'external',
                child: Row(
                  children: [
                    const Icon(Icons.open_in_new, color: Colors.black),
                    const SizedBox(width: 8),
                    const Text('Ouvrir dans le navigateur'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'refresh',
                child: Row(
                  children: [
                    const Icon(Icons.refresh, color: Colors.black),
                    const SizedBox(width: 8),
                    const Text('Actualiser'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'external') {
                _openInExternalBrowser();
              } else if (value == 'refresh') {
                _webViewController?.reload();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB71C1C), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(kWebviewUrl)),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() => _isLoading = true);
              },
              onLoadStop: (controller, url) {
                setState(() => _isLoading = false);
              },
              onLoadError: (controller, url, code, message) {
                debugPrint('WebView error: $code - $message');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erreur de chargement: $message'),
                    action: SnackBarAction(
                      label: 'Navigateur externe',
                      onPressed: _openInExternalBrowser,
                    ),
                  ),
                );
              },
              onLoadHttpError: (controller, url, statusCode, description) {
                debugPrint('WebView HTTP error: $statusCode - $description');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erreur HTTP $statusCode: $description'),
                    action: SnackBarAction(
                      label: 'Navigateur externe',
                      onPressed: _openInExternalBrowser,
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
                ),
              ),
              androidOnPermissionRequest: (controller, origin, resources) async {
                if (resources.contains('android.webkit.resource.AUDIO_CAPTURE')) {
                  return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT,
                  );
                }
                return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.DENY,
                );
              },
            ),
          ),
          if (_isLoading)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'Chargement de Liberchat...',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
