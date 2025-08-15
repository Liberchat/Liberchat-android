# Request For Packaging - Liberchat v3.5.0

**Application Name:** Liberchat  
**Version:** 3.5.0  
**License:** MIT  
**Repository:** https://github.com/Liberchat/Liberchat-android  
**Branch:** Liberchat3.5  

## Description

Liberchat is a modern, open-source chat application built with Flutter, dedicated to Android.

### Key Features:
- Modern and responsive interface
- Secure WebView with permission management
- Animated splash screen
- Elegant dark theme
- Server selection at startup (self-hosting possible)
- Tor support via Orbot for privacy

The application allows connecting to different chat servers and offers a smooth user experience with modern design.

## F-Droid Compliance

✅ **Open Source:** MIT License  
✅ **No Trackers:** Privacy-respecting application  
✅ **No Ads:** Clean, ad-free experience  
✅ **Reproducible Build:** Flutter with Gradle  
✅ **Complete Metadata:** YAML file ready  

## Technical Details

- **Platform:** Android (Flutter)
- **Build System:** Gradle
- **Dependencies:** Standard Flutter packages (no proprietary dependencies)
- **Target SDK:** Android API level compatible with F-Droid requirements

## Metadata File

The complete F-Droid metadata file is ready at:
`metadata/com.liberchat.mobile.yml`

## Build Instructions

```bash
flutter pub get
flutter build apk --release
```

## Repository Information

- **Main Repository:** https://github.com/Liberchat/Liberchat-android
- **Release Branch:** Liberchat3.5
- **Tagged Version:** v3.5.0
- **Application ID:** com.liberchat.mobile

## Additional Notes

This is a community-driven project focused on providing a free, open-source chat solution with privacy features like Tor support. The application is fully functional and ready for F-Droid distribution.

The metadata file follows F-Droid standards and includes all necessary build configurations for automated compilation.