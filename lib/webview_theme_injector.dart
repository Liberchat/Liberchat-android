import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'theme_manager.dart';

class WebViewThemeInjector {
  static String generateCSS(ThemeManager themeManager, bool isDarkMode) {
    final primaryColor = themeManager.primaryColor;
    final fontSize = themeManager.fontSize;
    
    // Convert Flutter color to hex
    final primaryHex = '#${primaryColor.toARGB32().toRadixString(16).substring(2)}';
    
    return '''
      <style id="liberchat-custom-theme">
        /* Custom CSS Variables */
        :root {
          --primary-color: $primaryHex !important;
          --primary-rgb: ${(primaryColor.r * 255.0).round().clamp(0, 255)}, ${(primaryColor.g * 255.0).round().clamp(0, 255)}, ${(primaryColor.b * 255.0).round().clamp(0, 255)} !important;
          --base-font-size: ${fontSize}px !important;
          --bg-color: ${isDarkMode ? '#1a1a1a' : '#ffffff'} !important;
          --text-color: ${isDarkMode ? '#ffffff' : '#000000'} !important;
          --secondary-bg: ${isDarkMode ? '#2d2d2d' : '#f5f5f5'} !important;
        }
        
        /* Global styles application */
        * {
          font-size: var(--base-font-size) !important;
        }
        
        body {
          background-color: var(--bg-color) !important;
          color: var(--text-color) !important;
          font-size: var(--base-font-size) !important;
        }
        
        /* Styles for main buttons */
        button, .btn, [role="button"] {
          background-color: var(--primary-color) !important;
          border-color: var(--primary-color) !important;
          font-size: var(--base-font-size) !important;
        }
        
        button:hover, .btn:hover, [role="button"]:hover {
          background-color: color-mix(in srgb, var(--primary-color) 80%, black) !important;
        }
        
        /* Styles for links */
        a {
          color: var(--primary-color) !important;
          font-size: var(--base-font-size) !important;
        }
        
        /* Styles for headings */
        h1 { font-size: calc(var(--base-font-size) + 8px) !important; }
        h2 { font-size: calc(var(--base-font-size) + 6px) !important; }
        h3 { font-size: calc(var(--base-font-size) + 4px) !important; }
        h4 { font-size: calc(var(--base-font-size) + 2px) !important; }
        h5 { font-size: calc(var(--base-font-size) + 1px) !important; }
        h6 { font-size: var(--base-font-size) !important; }
        
        /* Styles for paragraphs and text */
        p, span, div, label, input, textarea {
          font-size: var(--base-font-size) !important;
          color: var(--text-color) !important;
        }
        
        /* Styles for input fields */
        input, textarea, select {
          background-color: var(--secondary-bg) !important;
          border-color: var(--primary-color) !important;
          color: var(--text-color) !important;
          font-size: var(--base-font-size) !important;
        }
        
        input:focus, textarea:focus, select:focus {
          border-color: var(--primary-color) !important;
          box-shadow: 0 0 0 2px rgba(var(--primary-rgb), 0.2) !important;
        }
        
        /* Styles for cards and containers */
        .card, .panel, .container, .content {
          background-color: var(--secondary-bg) !important;
          color: var(--text-color) !important;
        }
        
        /* Styles for navigation bars */
        nav, .navbar, .header {
          background-color: var(--primary-color) !important;
        }
        
        /* Styles for active/selected elements */
        .active, .selected, .current {
          background-color: var(--primary-color) !important;
          color: white !important;
        }
        
        /* Styles for borders */
        .border, .bordered {
          border-color: var(--primary-color) !important;
        }
        
        /* Specific styles for LibreChat */
        .chat-message {
          font-size: var(--base-font-size) !important;
        }
        
        .chat-input {
          font-size: var(--base-font-size) !important;
          background-color: var(--secondary-bg) !important;
          color: var(--text-color) !important;
        }
        
        .sidebar {
          background-color: var(--secondary-bg) !important;
        }
        
        /* Animation for theme changes */
        * {
          transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease !important;
        }
        
        /* Styles for dark mode */
        ${isDarkMode ? '''
        body {
          background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%) !important;
          color: #ffffff !important;
        }
        
        .dark-mode {
          background-color: #1a1a1a !important;
          color: #ffffff !important;
        }
        
        /* Improvement of readability in dark mode */
        h1, h2, h3, h4, h5, h6 {
          color: #ffffff !important;
          text-shadow: 1px 1px 2px rgba(0,0,0,0.5) !important;
        }
        
        p, span, div, label {
          color: #e0e0e0 !important;
        }
        
        /* Improved contrast for links */
        a {
          color: var(--primary-color) !important;
          text-shadow: 0 0 2px rgba(var(--primary-rgb), 0.5) !important;
        }
        ''' : '''
        body {
          background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%) !important;
          color: #000000 !important;
        }
        
        .light-mode {
          background-color: #ffffff !important;
          color: #000000 !important;
        }
        
        /* Improvement of readability in light mode */
        h1, h2, h3, h4, h5, h6 {
          color: #1a1a1a !important;
          text-shadow: 1px 1px 2px rgba(255,255,255,0.5) !important;
        }
        
        p, span, div, label {
          color: #333333 !important;
        }
        '''}
      </style>
    ''';
  }

  static String generateJavaScript(ThemeManager themeManager, bool isDarkMode) {
    return '''
      (function() {
        // Remove old style if it exists
        const oldStyle = document.getElementById('liberchat-custom-theme');
        if (oldStyle) {
          oldStyle.remove();
        }
        
        // Inject new CSS
        const style = document.createElement('style');
        style.id = 'liberchat-custom-theme';
        style.innerHTML = \`${generateCSS(themeManager, isDarkMode).replaceAll('`', '\\`')}\`;
        document.head.appendChild(style);
        
        // Add classes to body
        document.body.classList.remove('light-mode', 'dark-mode');
        document.body.classList.add('${isDarkMode ? 'dark-mode' : 'light-mode'}');
        
        // Force styles refresh
        document.body.style.display = 'none';
        document.body.offsetHeight; // Trigger reflow
        document.body.style.display = '';
        
        console.log('Liberchat theme applied: ${themeManager.colorName}, Size: ${themeManager.fontSize}px, Mode: ${isDarkMode ? 'Dark' : 'Light'}');
      })();
    ''';
  }

  static Future<void> injectTheme(
    InAppWebViewController controller,
    ThemeManager themeManager,
    BuildContext context,
  ) async {
    try {
      // Determine if we are in dark mode
      final brightness = Theme.of(context).brightness;
      final isDarkMode = brightness == Brightness.dark;
      
      // Inject JavaScript that applies the theme
      await controller.evaluateJavascript(
        source: generateJavaScript(themeManager, isDarkMode),
      );
    } catch (e) {
      debugPrint('Error during theme injection: $e');
    }
  }
}