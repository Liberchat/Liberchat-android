import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'theme_manager.dart';

class WebViewThemeInjector {
  static String generateCSS(ThemeManager themeManager, bool isDarkMode) {
    final primaryColor = themeManager.primaryColor;
    final fontSize = themeManager.fontSize;
    
    // Convertir la couleur Flutter en hex
    final primaryHex = '#${primaryColor.value.toRadixString(16).substring(2)}';
    
    return '''
      <style id="liberchat-custom-theme">
        /* Variables CSS personnalisées */
        :root {
          --primary-color: $primaryHex !important;
          --primary-rgb: ${primaryColor.red}, ${primaryColor.green}, ${primaryColor.blue} !important;
          --base-font-size: ${fontSize}px !important;
          --bg-color: ${isDarkMode ? '#1a1a1a' : '#ffffff'} !important;
          --text-color: ${isDarkMode ? '#ffffff' : '#000000'} !important;
          --secondary-bg: ${isDarkMode ? '#2d2d2d' : '#f5f5f5'} !important;
        }
        
        /* Application des styles globaux */
        * {
          font-size: var(--base-font-size) !important;
        }
        
        body {
          background-color: var(--bg-color) !important;
          color: var(--text-color) !important;
          font-size: var(--base-font-size) !important;
        }
        
        /* Styles pour les boutons principaux */
        button, .btn, [role="button"] {
          background-color: var(--primary-color) !important;
          border-color: var(--primary-color) !important;
          font-size: var(--base-font-size) !important;
        }
        
        button:hover, .btn:hover, [role="button"]:hover {
          background-color: color-mix(in srgb, var(--primary-color) 80%, black) !important;
        }
        
        /* Styles pour les liens */
        a {
          color: var(--primary-color) !important;
          font-size: var(--base-font-size) !important;
        }
        
        /* Styles pour les titres */
        h1 { font-size: calc(var(--base-font-size) + 8px) !important; }
        h2 { font-size: calc(var(--base-font-size) + 6px) !important; }
        h3 { font-size: calc(var(--base-font-size) + 4px) !important; }
        h4 { font-size: calc(var(--base-font-size) + 2px) !important; }
        h5 { font-size: calc(var(--base-font-size) + 1px) !important; }
        h6 { font-size: var(--base-font-size) !important; }
        
        /* Styles pour les paragraphes et texte */
        p, span, div, label, input, textarea {
          font-size: var(--base-font-size) !important;
          color: var(--text-color) !important;
        }
        
        /* Styles pour les champs de saisie */
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
        
        /* Styles pour les cartes et conteneurs */
        .card, .panel, .container, .content {
          background-color: var(--secondary-bg) !important;
          color: var(--text-color) !important;
        }
        
        /* Styles pour les barres de navigation */
        nav, .navbar, .header {
          background-color: var(--primary-color) !important;
        }
        
        /* Styles pour les éléments actifs/sélectionnés */
        .active, .selected, .current {
          background-color: var(--primary-color) !important;
          color: white !important;
        }
        
        /* Styles pour les bordures */
        .border, .bordered {
          border-color: var(--primary-color) !important;
        }
        
        /* Styles spécifiques pour LibreChat */
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
        
        /* Animation pour les changements de thème */
        * {
          transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease !important;
        }
        
        /* Styles pour le mode sombre */
        ${isDarkMode ? '''
        body {
          background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%) !important;
          color: #ffffff !important;
        }
        
        .dark-mode {
          background-color: #1a1a1a !important;
          color: #ffffff !important;
        }
        
        /* Amélioration de la lisibilité en mode sombre */
        h1, h2, h3, h4, h5, h6 {
          color: #ffffff !important;
          text-shadow: 1px 1px 2px rgba(0,0,0,0.5) !important;
        }
        
        p, span, div, label {
          color: #e0e0e0 !important;
        }
        
        /* Contraste amélioré pour les liens */
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
        
        /* Amélioration de la lisibilité en mode clair */
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
        // Supprimer l'ancien style s'il existe
        const oldStyle = document.getElementById('liberchat-custom-theme');
        if (oldStyle) {
          oldStyle.remove();
        }
        
        // Injecter le nouveau CSS
        const style = document.createElement('style');
        style.id = 'liberchat-custom-theme';
        style.innerHTML = \`${generateCSS(themeManager, isDarkMode).replaceAll('`', '\\`')}\`;
        document.head.appendChild(style);
        
        // Ajouter des classes au body
        document.body.classList.remove('light-mode', 'dark-mode');
        document.body.classList.add('${isDarkMode ? 'dark-mode' : 'light-mode'}');
        
        // Forcer le rafraîchissement des styles
        document.body.style.display = 'none';
        document.body.offsetHeight; // Trigger reflow
        document.body.style.display = '';
        
        console.log('Thème Liberchat appliqué: ${themeManager.colorName}, Taille: ${themeManager.fontSize}px, Mode: ${isDarkMode ? 'Sombre' : 'Clair'}');
      })();
    ''';
  }

  static Future<void> injectTheme(
    InAppWebViewController controller,
    ThemeManager themeManager,
    BuildContext context,
  ) async {
    try {
      // Déterminer si on est en mode sombre
      final brightness = Theme.of(context).brightness;
      final isDarkMode = brightness == Brightness.dark;
      
      // Injecter le JavaScript qui applique le thème
      await controller.evaluateJavascript(
        source: generateJavaScript(themeManager, isDarkMode),
      );
    } catch (e) {
      debugPrint('Erreur lors de l\'injection du thème: $e');
    }
  }
}