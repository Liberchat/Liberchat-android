import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'permission_request.dart';

const String kWebviewUrl = 'https://liberchat.cnt-ait-contact.noho.st/liberchat/';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  InAppWebViewController? _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestAllPermissions(context);
    });
  }

  Future<void> _openInExternalBrowser() async {
    try {
      await launchUrl(Uri.parse(kWebviewUrl), mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
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
                    const Text('Open in browser'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'refresh',
                child: Row(
                  children: [
                    const Icon(Icons.refresh, color: Colors.black),
                    const SizedBox(width: 8),
                    const Text('Refresh'),
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
              onReceivedError: (controller, request, error) {
                debugPrint('WebView error: ${error.type} - ${error.description}');
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Loading error: ${error.description}'),
                      action: SnackBarAction(
                        label: 'External browser',
                        onPressed: _openInExternalBrowser,
                      ),
                    ),
                  );
                }
              },
              onReceivedHttpError: (controller, request, errorResponse) {
                debugPrint('WebView HTTP error: ${errorResponse.statusCode}');
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('HTTP error ${errorResponse.statusCode}'),
                      action: SnackBarAction(
                        label: 'External browser',
                        onPressed: _openInExternalBrowser,
                      ),
                    ),
                  );
                }
              },
              initialSettings: InAppWebViewSettings(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                javaScriptEnabled: true,
                clearCache: false,
                cacheEnabled: true,
                userAgent: 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36',
                mixedContentMode: MixedContentMode.MIXED_CONTENT_COMPATIBILITY_MODE,
              ),
              onPermissionRequest: (controller, request) async {
                if (request.resources.any((r) => r.toString().contains('AUDIO_CAPTURE') || r == PermissionResourceType.MICROPHONE)) {
                  return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT,
                  );
                }
                return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.DENY,
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
