#!/usr/bin/env python3
"""
Script pour soumettre automatiquement une Request For Packaging (RFP) à F-Droid
"""

import webbrowser
import urllib.parse
import sys

def create_rfp_submission():
    """Crée et ouvre la soumission RFP F-Droid"""
    
    # Informations de l'application
    app_name = "Liberchat"
    version = "3.5.0"
    repo_url = "https://github.com/Liberchat/Liberchat-android"
    branch = "Liberchat3.5"
    license_type = "MIT"
    
    # Titre de l'issue
    title = f"Add {app_name} v{version} - Modern open-source chat application"
    
    # Description de l'issue
    description = f"""**Application Name:** {app_name}
**Version:** {version}
**License:** {license_type}
**Repository:** {repo_url}
**Branch:** {branch}

## Description

Liberchat is a modern, open-source chat application built with Flutter, dedicated to Android.

### Key Features:
- Modern and responsive interface
- Secure WebView with permission management
- Animated splash screen
- Elegant dark theme
- Server selection at startup (self-hosting possible)
- Tor support via Orbot for privacy

## F-Droid Compliance

✅ **Open Source:** MIT License
✅ **No Trackers:** Privacy-respecting application
✅ **No Ads:** Clean, ad-free experience
✅ **Reproducible Build:** Flutter with Gradle
✅ **Complete Metadata:** YAML file ready

## Technical Details

- **Platform:** Android (Flutter)
- **Application ID:** com.liberchat.mobile
- **Build System:** Gradle
- **Target SDK:** Compatible with F-Droid requirements

## Metadata File

The complete F-Droid metadata file is ready in the repository at:
`metadata/com.liberchat.mobile.yml`

## Build Instructions

```bash
flutter pub get
flutter build apk --release
```

## Additional Information

This is a community-driven project focused on providing a free, open-source chat solution with privacy features. The application is fully functional and ready for F-Droid distribution.

The metadata file follows F-Droid standards and includes all necessary build configurations for automated compilation.
"""

    # URL de base pour créer une nouvelle issue
    base_url = "https://gitlab.com/fdroid/rfp/-/issues/new"
    
    # Paramètres URL encodés
    params = {
        'issue[title]': title,
        'issue[description]': description
    }
    
    # Construction de l'URL complète
    url_params = urllib.parse.urlencode(params)
    full_url = f"{base_url}?{url_params}"
    
    print("🚀 Soumission F-Droid RFP pour Liberchat v3.5.0")
    print("=" * 50)
    print(f"Titre: {title}")
    print(f"Repository: {repo_url}")
    print(f"Licence: {license_type}")
    print("=" * 50)
    
    print("\n📋 Ouverture de la page de soumission F-Droid...")
    print("🌐 URL:", "https://gitlab.com/fdroid/rfp/-/issues/new")
    
    try:
        # Ouvrir l'URL dans le navigateur
        webbrowser.open(full_url)
        print("✅ Page ouverte dans le navigateur !")
        print("\n📝 Instructions:")
        print("1. Connecte-toi à GitLab si nécessaire")
        print("2. Vérifie que le titre et la description sont corrects")
        print("3. Clique sur 'Create issue'")
        print("4. Attends la review de l'équipe F-Droid")
        
    except Exception as e:
        print(f"❌ Erreur lors de l'ouverture: {e}")
        print(f"\n🔗 Copie cette URL manuellement:")
        print(full_url)
        
    print(f"\n🎉 Soumission prête ! L'équipe F-Droid va reviewer Liberchat v{version}")
    return True

if __name__ == "__main__":
    create_rfp_submission()