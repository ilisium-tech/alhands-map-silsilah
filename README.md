# Silsilah App - Modern Family Tree Gallery

A full-featured Flutter SaaS mobile application for exploring family trees with interactive maps, built with Clean Architecture, GetX state management, and GoRouter navigation.

## 🎯 Features

### Core Features
- **Interactive Family Map**: View family members on an interactive map across Java Island, Indonesia
- **Family Gallery**: Browse through family photos with search functionality
- **User Authentication**: Demo login system with Free and Premium user roles
- **Responsive Design**: Support for light/dark themes with beautiful UI/UX
- **Search Functionality**: Search family members by name, location, or other attributes

### Premium Features
- **Mapbox Integration**: High-quality maps for premium users
- **Advanced Search**: Enhanced search capabilities
- **Cloud Sync**: Data synchronization (placeholder)
- **Data Export**: Export family data functionality

### Free Features
- **OpenStreetMap**: Basic map functionality for free users
- **Basic Search**: Standard search features
- **Local Storage**: Data stored locally

## 🏗️ Architecture

This app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                   # Core functionality
│   ├── constants/         # App constants
│   ├── themes/           # App themes and styling
│   └── error/            # Error handling
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

## 🛠️ Tech Stack

- **Flutter 3+** - Cross-platform mobile framework
- **Dart** - Programming language
- **GetX** - State management and dependency injection
- **GoRouter** - Declarative routing and navigation
- **Flutter Map** - OpenStreetMap integration for free users
- **Mapbox SDK** - Premium map experience
- **GetStorage** - Local data persistence
- **Cached Network Image** - Efficient image loading and caching

## 📱 Screenshots & Demo

### Authentication
- Login page with Free/Premium user options
- Role-based feature access

### Home Dashboard
- Welcome card with user info
- Feature grid with navigation
- Statistics overview

### Family Map
- Interactive map with family member markers
- Search functionality
- Member detail modals
- Map type switching (Premium)

### Gallery
- Grid view of family photos
- Search and filter capabilities
- Member detail views

### Profile & Settings
- User profile management
- Theme switching (Light/Dark/System)
- Premium upgrade prompts
- App settings and preferences

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS development setup (for iOS builds)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ilisium-tech/alhands-map-silsilah.git
   cd alhands-map-silsilah
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Mapbox (Optional)**
   - Get a Mapbox access token from [Mapbox](https://www.mapbox.com/)
   - Replace `YOUR_MAPBOX_ACCESS_TOKEN_HERE` in `lib/core/constants/app_constants.dart`

4. **Run the app**
   ```bash
   flutter run
   ```

### Demo Accounts

The app includes demo authentication:

**Free User Account:**
- Features: OpenStreetMap, basic search, local storage
- Login: Use "Masuk sebagai Gratis" button

**Premium User Account:**
- Features: Mapbox maps, advanced search, cloud sync, data export
- Login: Use "Masuk sebagai Premium" button

## 📊 Mock Data

The app includes 55+ mock family members with:
- Indonesian names and locations
- Random coordinates across Java Island
- Profile photos from Unsplash
- Realistic family relationships
- Various occupations and ages
- Contact information and descriptions

## 🗺️ Map Features

### Free Users (OpenStreetMap)
- Basic map tiles from OpenStreetMap
- Family member markers with photos
- Search and navigation
- Member detail views

### Premium Users (Mapbox)
- High-quality Mapbox tiles
- Multiple map styles (Streets, Satellite, Terrain)
- Enhanced map interactions
- Premium-only features

## 🎨 UI/UX Features

- **Material Design 3** with custom theming
- **Poppins font** for modern typography
- **Light/Dark theme** support with system preference detection
- **Responsive design** for various screen sizes
- **Smooth animations** and transitions
- **Indonesian localization** for better user experience

## 🔧 Configuration

### Theme Customization
Modify themes in `lib/core/themes/app_theme.dart`:
- Primary and secondary colors
- Typography settings
- Component themes

### Constants
Update app constants in `lib/core/constants/app_constants.dart`:
- API endpoints
- Map configuration
- UI constants

### Mock Data
Customize family data in `lib/data/datasources/family_member_datasource.dart`:
- Add more family members
- Modify locations and relationships
- Update photo URLs

## 📦 Dependencies

### Core Dependencies
```yaml
get: ^4.6.6                    # State management
go_router: ^12.1.3             # Navigation
get_storage: ^2.1.1            # Local storage
flutter_map: ^6.1.0            # OpenStreetMap
mapbox_maps_flutter: ^1.0.0    # Mapbox integration
cached_network_image: ^3.3.0   # Image caching
```

### Development Dependencies
```yaml
flutter_lints: ^3.0.0         # Linting rules
build_runner: ^2.4.7          # Code generation
json_serializable: ^6.7.1     # JSON serialization
```

## 🚀 Building for Production

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **GetX Team** for state management solution
- **Mapbox** for premium map services
- **OpenStreetMap** for free map tiles
- **Unsplash** for demo profile photos

## 📞 Support

For support and questions:
- Email: support@silsilah.com
- WhatsApp: +62 812-3456-7890
- Website: www.silsilah.com

---

**Silsilah App** - Connecting families through technology 👨‍👩‍👧‍👦
