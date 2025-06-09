class AppConstants {
  // App Info
  static const String appName = 'Silsilah App';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String userRoleKey = 'user_role';
  static const String themeKey = 'theme_mode';
  static const String isFirstTimeKey = 'is_first_time';
  
  // User Roles
  static const String freeUser = 'free';
  static const String premiumUser = 'premium';
  
  // Map Configuration
  static const String mapboxAccessToken = 'YOUR_MAPBOX_ACCESS_TOKEN_HERE';
  static const String openStreetMapUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  
  // Java Island Bounds
  static const double javaMinLat = -8.8;
  static const double javaMaxLat = -5.9;
  static const double javaMinLng = 105.0;
  static const double javaMaxLng = 114.6;
  
  // Default Map Center (Jakarta)
  static const double defaultLat = -6.2088;
  static const double defaultLng = 106.8456;
  static const double defaultZoom = 8.0;
  
  // API Endpoints (for future use)
  static const String baseUrl = 'https://api.silsilah.com';
  static const String familyMembersEndpoint = '/family-members';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;
  
  // Family Member Photo Sizes
  static const double markerPhotoSize = 40.0;
  static const double detailPhotoSize = 120.0;
  static const double galleryPhotoSize = 80.0;
}