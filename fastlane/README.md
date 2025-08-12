# Fastlane for Liberchat

This directory contains Fastlane configuration for Liberchat F-Droid integration.

## Setup

```bash
# Install dependencies
bundle install

# Generate screenshots
bundle exec fastlane screenshots

# Build release
bundle exec fastlane build_release
```

## F-Droid Integration

The Fastlane configuration provides:
- Automated screenshot generation
- Metadata management for multiple locales
- Release build automation
- F-Droid compatibility

## Locales Supported

- English (en-US)
- French (fr-FR)

## Screenshots

Screenshots are automatically generated and stored in `fastlane/metadata/android/[locale]/images/`