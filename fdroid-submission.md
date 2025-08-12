# Soumission F-Droid - Liberchat

## Informations de l'application

**Nom :** Liberchat  
**ID :** com.liberchat.mobile  
**Version :** 3.5.0  
**Licence :** MIT  
**Dépôt :** https://github.com/Liberchat/Liberchat-android  
**Branche :** Liberchat3.5  

## Description

Liberchat est une application de chat moderne, open-source, basée sur Flutter et dédiée uniquement à Android.

### Fonctionnalités principales :
- Interface moderne et responsive
- WebView sécurisé avec gestion des permissions
- Splash screen animé
- Thème sombre élégant
- Sélection du serveur au démarrage (auto-hébergement possible)
- Support de Tor via Orbot pour la confidentialité

## Conformité F-Droid

✅ **Code source libre** : Licence MIT  
✅ **Pas de trackers** : Application respectueuse de la vie privée  
✅ **Pas de publicités**  
✅ **Build reproductible** : Flutter avec Gradle  
✅ **Métadonnées complètes** : Fichier YAML prêt  

## Fichiers importants

- `metadata/com.liberchat.mobile.yml` - Métadonnées F-Droid
- `pubspec.yaml` - Configuration Flutter
- `android/app/build.gradle.kts` - Configuration Android

## Instructions de build

```bash
flutter pub get
flutter build apk --release
```

## Soumission

Le fichier de métadonnées est prêt à être ajouté au dépôt F-Droid :
https://gitlab.com/fdroid/fdroiddata

Copier le fichier `metadata/com.liberchat.mobile.yml` dans le dossier `metadata/` du dépôt F-Droid.