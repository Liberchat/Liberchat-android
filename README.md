# Liberchat

<p align="center">
  <img src="assets/logo.png" alt="Liberchat Logo" width="120" />
</p>

<p align="center">
  <a href="https://github.com/Liberchat/Liberchat-android/releases"><img src="https://img.shields.io/github/v/release/Liberchat/Liberchat-android?label=version&logo=github" alt="Latest Release"></a>
  <img src="https://img.shields.io/badge/Flutter-Android%20Only-green?logo=android" alt="Platform Android">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License">

</p>

---

Liberchat est une application de chat moderne, open-source, basée sur Flutter et dédiée uniquement à Android.

**Version actuelle :** 3.6.0 | 

## ✨ Fonctionnalités
- 🎨 Interface moderne et responsive
- 🔒 WebView sécurisé avec gestion des permissions
- ✨ Splash screen animé avec gradient dynamique
- 🌙 Thème sombre élégant avec personnalisation
- 🎯 Icône personnalisée avec fallback automatique
- 🌐 Sélection du serveur au démarrage (auto-hébergement possible)
- 🔐 Support de Tor via Orbot pour la confidentialité
- 📱 Optimisé pour Android uniquement
- 📁 **NOUVEAU** - Gestion complète du stockage et des médias
- 🎤 **NOUVEAU** - Permissions audio avancées
- 📥 **NOUVEAU** - Support des téléchargements
- 🔧 **NOUVEAU** - Gestion d'erreurs améliorée
- ⚙️ **NOUVEAU** - Écran de paramètres intégré
- 🎨 **NOUVEAU** - Injection de thème dynamique dans WebView

## 📦 Installation

### APK Direct
Téléchargez la dernière version APK depuis :
- [Releases GitHub](https://github.com/Liberchat/Liberchat-android/releases/tag/v3.6.0)
- APK disponible : `app-release.apk` (49.3 MB)

### Installation manuelle
```bash
# Téléchargez l'APK et installez
adb install app-release.apk
```

## 🚀 Développement local
```bash
# Clonez le repo
git clone https://github.com/Liberchat/Liberchat-android
cd Liberchat-android

# Installez les dépendances
flutter pub get

# Lancez l'application sur Android
flutter run
```

## 🛠️ Développement

### Prérequis
- Flutter 3.8.1+
- Android SDK
- Dart SDK

### Configuration
```bash
# Vérifiez votre installation Flutter
flutter doctor

# Installez les dépendances
flutter pub get

# Compilez l'APK
flutter build apk --release
```

### Structure du projet
- `lib/` - Code source principal
- `android/` - Configuration Android
- `assets/` - Ressources (logos, images)
- `metadata/` - Métadonnées F-Droid

### Dépendances principales
- `flutter_inappwebview` ^6.0.0 - WebView sécurisé
- `permission_handler` ^11.0.1 - Gestion des permissions
- `socket_io_client` ^2.0.3 - Communication temps réel
- `encrypt` ^5.0.3 - Chiffrement
- `shared_preferences` ^2.2.2 - Stockage local
- `provider` ^6.1.1 - Gestion d'état
- `url_launcher` ^6.2.5 - Ouverture d'URLs
- `flutter_custom_tabs` ^1.2.0 - Onglets personnalisés

## 🔒 Confidentialité et Sécurité

Liberchat respecte votre vie privée :
- ✅ **Aucun tracker** - Pas de collecte de données
- ✅ **Open Source** - Code source entièrement accessible
- ✅ **Support Tor** - Navigation anonyme via Orbot
- ✅ **Auto-hébergement** - Connectez-vous à votre propre serveur
- ✅ **Chiffrement** - Communications sécurisées
- ✅ **Permissions granulaires** - Contrôle précis des accès
- ✅ **Stockage sécurisé** - Gestion sécurisée des fichiers

## 📊 F-Droid

**Statut :** Mise à jour en cours 🔄  
**Version :** 3.6.0  
**ID d'application :** `com.liberchat.mobile`  
**Licence :** MIT  

L'application respecte toutes les exigences F-Droid :
- Code source libre
- Pas de trackers ou publicités
- Build reproductible
- Métadonnées complètes

## 🤝 Contribuer

Les contributions sont les bienvenues ! 

### Comment contribuer :
1. Fork le projet
2. Créez une branche feature (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

### Signaler des bugs
Ouvrez une [issue](https://github.com/Liberchat/Liberchat-android/issues) avec :
- Description du problème
- Étapes pour reproduire
- Version d'Android
- Logs si possible

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE.md](LICENSE.md) pour plus de détails.

## 🔗 Liens utiles

- [Site web](https://github.com/Liberchat)
- [Issues](https://github.com/Liberchat/Liberchat-android/issues)
- [Releases](https://github.com/Liberchat/Liberchat-android/releases)
- [F-Droid RFP](https://gitlab.com/fdroid/rfp/-/issues)

---

## 🆕 Nouveautés v3.6.0

### Gestion du stockage
- Support complet des permissions de stockage Android
- Accès aux médias (images, vidéos, audio)
- Téléchargements sans notification
- Compatibilité Android 13+ (API 33)

### Interface utilisateur
- Écran de paramètres avec gestion des thèmes
- Injection dynamique de thème dans WebView
- Gestion d'erreurs avec fallback automatique
- Indicateurs de connexion améliorés

### Permissions
- Demande automatique de toutes les permissions
- Messages d'erreur informatifs
- Gestion granulaire des accès

---

<p align="center">
  <b>Made with ❤️ by the Liberchat team</b><br>
  <i>Liberchat v3.6.0 - Janvier 2025</i>
</p>
