import 'package:flutter/material.dart';

class ErrorHandler {
  static void initialize() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      debugPrint('Flutter Error: ${details.exception}');
      debugPrint('Stack trace: ${details.stack}');
    };
  }

  static Widget buildErrorWidget(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Error',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFallbackLogo({double size = 120}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.red.shade900,
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.3),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        Icons.chat_bubble_outline,
        size: size * 0.5,
        color: Colors.white,
      ),
    );
  }
}