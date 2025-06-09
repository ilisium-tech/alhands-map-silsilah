# Flutter Project Setup Guide

## Prerequisites

Before running this Flutter project, ensure you have:

1. **Flutter SDK** (>=3.16.0)
2. **Dart SDK** (>=3.2.3)
3. **Android Studio** or **VS Code** with Flutter extensions
4. **Xcode** (for iOS development on macOS)

## Installation Steps

### 1. Clone and Setup
```bash
git clone https://github.com/ilisium-tech/alhands-map-silsilah.git
cd alhands-map-silsilah
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure API Keys (Optional)

#### Mapbox Configuration
1. Get a Mapbox access token from [Mapbox](https://www.mapbox.com/)
2. Replace `YOUR_MAPBOX_ACCESS_TOKEN_HERE` in `lib/core/constants/app_constants.dart`

### 4. Download Required Assets

#### Fonts
Download Poppins font family from [Google Fonts](https://fonts.google.com/specimen/Poppins):
- Poppins-Regular.ttf
- Poppins-Medium.ttf
- Poppins-SemiBold.ttf
- Poppins-Bold.ttf

Place them in `assets/fonts/` directory.

#### Icons (Optional)
Add app icons to `assets/icons/` directory.

### 5. Platform-Specific Setup

#### Android
1. Open `android/` folder in Android Studio
2. Sync Gradle files
3. Ensure minimum SDK version is 21+

#### iOS
1. Open `ios/Runner.xcworkspace` in Xcode
2. Configure signing certificates
3. Ensure deployment target is iOS 11.0+

#### Web
No additional setup required for web deployment.

## Running the App

### Development Mode
```bash
# Run on connected device/emulator
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d android         # Android
flutter run -d ios            # iOS
```

### Build for Production

#### Android
```bash
# APK
flutter build apk --release

# App Bundle (recommended for Play Store)
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

## Project Structure

```
lib/
├── core/                   # Core functionality
│   ├── constants/         # App constants and configuration
│   ├── themes/           # App themes and styling
│   ├── error/            # Error handling
│   └── utils/            # Utility functions
├── data/                  # Data layer
│   ├── datasources/      # Data sources (API, local)
│   ├── models/           # Data models
│   └── repositories/     # Repository implementations
├── domain/               # Domain layer
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business use cases
├── presentation/         # Presentation layer
│   ├── controllers/      # GetX controllers
│   ├── pages/           # UI pages
│   └── components/      # Reusable UI components
├── routes/              # Navigation configuration
└── main.dart           # App entry point
```

## Features

### Implemented Features
- ✅ Clean Architecture with GetX
- ✅ GoRouter navigation with deep linking
- ✅ Authentication system (demo)
- ✅ Family map with OpenStreetMap/Mapbox
- ✅ Gallery with search functionality
- ✅ Theme switching (Light/Dark)
- ✅ Premium/Free user roles
- ✅ Responsive design
- ✅ Mock data with 55+ family members

### Demo Accounts
- **Free User**: Basic features with OpenStreetMap
- **Premium User**: Enhanced features with Mapbox

## Troubleshooting

### Common Issues

#### 1. Dependencies Issues
```bash
flutter clean
flutter pub get
```

#### 2. Platform-Specific Issues
```bash
# Android
cd android && ./gradlew clean && cd ..

# iOS
cd ios && rm -rf Pods Podfile.lock && pod install && cd ..
```

#### 3. Font Issues
Ensure font files are placed in `assets/fonts/` and referenced correctly in `pubspec.yaml`.

#### 4. Map Issues
- Check internet connection for map tiles
- Verify Mapbox token if using premium features
- Ensure location permissions are granted

### Getting Help

1. Check Flutter documentation: https://flutter.dev/docs
2. GetX documentation: https://github.com/jonataslaw/getx
3. GoRouter documentation: https://pub.dev/packages/go_router
4. Open an issue in the repository

## Development Guidelines

### Code Style
- Follow Dart/Flutter conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

### State Management
- Use GetX for state management
- Follow reactive programming patterns
- Separate business logic from UI

### Architecture
- Maintain Clean Architecture principles
- Keep layers separated
- Use dependency injection
- Write testable code

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.