# Liberchat

<p align="center">
  <img src="assets/logo.png" alt="Liberchat Logo" width="120" />
</p>

<p align="center">
  <a href="https://github.com/Liberchat/Liberchat-android/releases"><img src="https://img.shields.io/github/v/release/Liberchat/Liberchat-android?label=version&logo=github" alt="Latest Release"></a>
  <img src="https://img.shields.io/badge/Flutter-Android%20Only-green?logo=android" alt="Platform Android">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License">
  <img src="https://img.shields.io/badge/F--Droid-Submitted-orange?logo=f-droid" alt="F-Droid Status">
</p>

---

Liberchat est une application de chat moderne, open-source, basée sur Flutter et dédiée uniquement à Android.

**Version actuelle :** 3.5.1| **Soumise à F-Droid** 🎉

## ✨ Fonctionnalités
- 🎨 Interface moderne et responsive
- 🔒 WebView sécurisé avec gestion des permissions
- ✨ Splash screen animé
- 🌙 Thème sombre élégant
- 🎯 Icône personnalisée
- 🌐 Sélection du serveur au démarrage (auto-hébergement possible)
- 🔐 Support de Tor via Orbot pour la confidentialité
- 📱 Optimisé pour Android uniquement

## 📦 Installation

### F-Droid (Recommandé)
🚀 **Liberchat v3.5.1 a été soumise à F-Droid !**

L'application sera bientôt disponible sur F-Droid. En attendant l'approbation, vous pouvez :

### APK Direct
Téléchargez la dernière version APK depuis :
- [Releases GitHub](https://github.com/Liberchat/Liberchat-android/releases/tag/v3.5.0)
- APK disponible : `Liberchat-3.5.apk` (22.3 MB)

### Installation manuelle
```bash
# Téléchargez l'APK et installez
adb install Liberchat-3.5.apk
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
- `flutter_inappwebview` - WebView sécurisé
- `permission_handler` - Gestion des permissions
- `socket_io_client` - Communication temps réel
- `encrypt` - Chiffrement
- `shared_preferences` - Stockage local

## 🔒 Confidentialité et Sécurité

Liberchat respecte votre vie privée :
- ✅ **Aucun tracker** - Pas de collecte de données
- ✅ **Open Source** - Code source entièrement accessible
- ✅ **Support Tor** - Navigation anonyme via Orbot
- ✅ **Auto-hébergement** - Connectez-vous à votre propre serveur
- ✅ **Chiffrement** - Communications sécurisées

## 📊 F-Droid

**Statut :** Soumise ✅  
**Version :** 3.5.0  
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

<p align="center">
  <b>Made with ❤️ by the Liberchat team</b><br>
  <i>Liberchat v3.5.0 - Soumise à F-Droid le 12 août 2025</i>
</p>