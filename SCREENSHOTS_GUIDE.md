# 📸 GUIDE DES CAPTURES D'ÉCRAN FASTLANE

## 🎯 **COMMENT ÇA MARCHE**

### **Principe des captures automatiques :**
1. **Fastlane lance** l'app sur un émulateur Android
2. **Screengrab navigue** automatiquement dans l'interface
3. **Prend des captures** à des moments précis du code
4. **Sauvegarde les images** dans `fastlane/metadata/android/[locale]/images/`
5. **F-Droid utilise** ces images dans le store

## 🛠️ **CONFIGURATION CRÉÉE**

### **Fichiers ajoutés :**
- `android/app/src/debug/java/com/liberchat/mobile/ScreengrabConfig.java` - Test automatisé
- `android/app/build.gradle.kts` - Dépendances de test mises à jour
- `fastlane/Fastfile` - Configuration Screengrab

### **Captures programmées :**
1. **01_splash_screen** - Écran de démarrage/splash
2. **02_server_selection** - Sélection du serveur
3. **03_main_interface** - Interface principale de chat
4. **04_menu** - Menu ou vue secondaire
5. **05_dark_theme** - Thème sombre

## 🚀 **UTILISATION**

### **Prérequis :**
```bash
# Installer les dépendances Ruby
bundle install

# Démarrer un émulateur Android
# Ou connecter un appareil physique
```

### **Générer les captures :**
```bash
# Générer toutes les captures
bundle exec fastlane screenshots

# Ou manuellement :
cd android
./gradlew assembleDebug assembleDebugAndroidTest
bundle exec screengrab
```

### **Résultat :**
Les images seront créées dans :
```
fastlane/metadata/android/
├── en-US/images/
│   ├── phoneScreenshots/
│   │   ├── 01_splash_screen.png
│   │   ├── 02_server_selection.png
│   │   ├── 03_main_interface.png
│   │   ├── 04_menu.png
│   │   └── 05_dark_theme.png
└── fr-FR/images/
    └── phoneScreenshots/
        ├── 01_splash_screen.png
        ├── 02_server_selection.png
        ├── 03_main_interface.png
        ├── 04_menu.png
        └── 05_dark_theme.png
```

## 🎨 **PERSONNALISATION**

### **Modifier les captures :**
Édite `android/app/src/debug/java/com/liberchat/mobile/ScreengrabConfig.java` :

```java
// Ajouter une nouvelle capture
Screengrab.screenshot("06_settings");

// Interagir avec l'interface
UiObject button = device.findObject(new UiSelector().text("Paramètres"));
if (button.exists()) {
    button.click();
    Thread.sleep(1000);
    Screengrab.screenshot("07_settings_page");
}
```

### **Langues supportées :**
- `en-US` - Anglais
- `fr-FR` - Français

Pour ajouter d'autres langues, modifie `fastlane/Fastfile` :
```ruby
locales: ['en-US', 'fr-FR', 'es-ES', 'de-DE']
```

## 🔧 **DÉPANNAGE**

### **Problèmes courants :**

**Émulateur non détecté :**
```bash
adb devices  # Vérifier les appareils connectés
```

**App ne se lance pas :**
```bash
flutter clean
flutter pub get
flutter build apk --debug
```

**Captures vides :**
- Augmenter les `Thread.sleep()` dans le test
- Vérifier que l'émulateur a assez de RAM
- Utiliser un émulateur avec API 28+

## 📱 **POUR F-DROID**

### **Avantages :**
- ✅ **Automatique** - Pas besoin de captures manuelles
- ✅ **Multilingue** - Captures dans chaque langue
- ✅ **Cohérent** - Même qualité à chaque fois
- ✅ **Reproductible** - F-Droid peut regénérer

### **F-Droid utilise ces captures pour :**
- Affichage dans le store F-Droid
- Aperçu de l'app avant installation
- Promotion de l'app
- Documentation visuelle

## 🎉 **RÉSULTAT**

Avec cette configuration, **F-Droid pourra automatiquement générer de belles captures d'écran** de Liberchat dans plusieurs langues, rendant l'app plus attractive pour les utilisateurs !

Les captures montreront :
- 🎨 L'interface moderne de Liberchat
- 🌙 Le thème sombre élégant
- 🌐 La sélection de serveur
- 📱 L'expérience utilisateur complète