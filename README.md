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

Liberchat is a modern, open-source chat application, based on Flutter and dedicated exclusively to Android.

**Current Version:** 3.6.0 | 

## ✨ Features
-  Modern and responsive interface
-  Secure WebView with permission management
-  Animated splash screen with dynamic gradient
-  Elegant dark theme with customization
-  Custom icon with automatic fallback
-  Server selection at startup (self-hosting possible)
-  Tor support via Orbot for privacy
-  Optimized for Android only
-  **NEW** - Full storage and media management
-  **NEW** - Advanced audio permissions
-  **NEW** - Download support
-  **NEW** - Improved error handling
-  **NEW** - Integrated settings screen
-  **NEW** - Dynamic theme injection in WebView

##  Installation

### Direct APK
Download the latest APK version from:
- [GitHub Releases](https://github.com/Liberchat/Liberchat-android/releases/tag/v3.6.0)
- Available APK: `app-release.apk` (49.3 MB)

### Manual Installation
```bash
# Download the APK and install
adb install app-release.apk
```

## Local Development
```bash
# Clone the repo
git clone https://github.com/Liberchat/Liberchat-android
cd Liberchat-android

# Install dependencies
flutter pub get

# Run the application on Android
flutter run
```

## Development

### Prerequisites
- Flutter 3.8.1+
- Android SDK
- Dart SDK

### Configuration
```bash
# Check your Flutter installation
flutter doctor

# Install dependencies
flutter pub get

# Build the APK
flutter build apk --release
```

### Project Structure
- `lib/` - Main source code
- `android/` - Android configuration
- `assets/` - Resources (logos, images)
- `metadata/` - F-Droid metadata

### Main Dependencies
- `flutter_inappwebview` ^6.0.0 - Secure WebView
- `permission_handler` ^11.0.1 - Permission management
- `socket_io_client` ^2.0.3 - Real-time communication
- `encrypt` ^5.0.3 - Encryption
- `shared_preferences` ^2.2.2 - Local storage
- `provider` ^6.1.1 - State management
- `url_launcher` ^6.2.5 - Opening URLs
- `flutter_custom_tabs` ^1.2.0 - Custom tabs

##  Privacy and Security

Liberchat respects your privacy:
-  **No trackers** - No data collection
-  **Open Source** - Fully accessible source code
-  **Tor Support** - Anonymous navigation via Orbot
-  **Self-hosting** - Connect to your own server
-  **Encryption** - Secure communications
-  **Granular Permissions** - Precise access control
-  **Secure Storage** - Secure file management

## F-Droid

**Status:** Update in progress 🔄  
**Version:** 3.6.0  
**Application ID:** `com.liberchat.mobile`  
**License:** MIT  

The application meets all F-Droid requirements:
- Free source code
- No trackers or ads
- Reproducible build
- Complete metadata

##  Contributing

Contributions are welcome! 

### How to contribute:
1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Reporting bugs
Open an [issue](https://github.com/Liberchat/Liberchat-android/issues) with:
- Problem description
- Steps to reproduce
- Android version
- Logs if possible

## License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for more details.


## What's New v3.6.0

### Storage Management
- Full support for Android storage permissions
- Media access (images, videos, audio)
- Downloads without notification
- Android 13+ compatibility (API 33)

### User Interface
- Settings screen with theme management
- Dynamic theme injection in WebView
- Error management with automatic fallback
- Improved connection indicators

### Permissions
- Automatic request for all permissions
- Informative error messages
- Granular access management

---

<p align="center">
  <b>Made with ❤️ by the Liberchat team</b><br>
  <i>Liberchat v3.6.0 - January 2025</i>
</p>
