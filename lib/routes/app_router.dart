import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

import '../presentation/controllers/auth_controller.dart';
import '../presentation/pages/splash_page.dart';
import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/family_map/family_map_page.dart';
import '../presentation/pages/gallery/gallery_page.dart';
import '../presentation/pages/profile/profile_page.dart';
import '../presentation/pages/settings/settings_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String familyMap = '/family-map';
  static const String gallery = '/gallery';
  static const String profile = '/profile';
  static const String settings = '/settings';

  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: splash,
      redirect: _redirect,
      routes: [
        GoRoute(
          path: splash,
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: login,
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: home,
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: familyMap,
          name: 'family-map',
          builder: (context, state) => const FamilyMapPage(),
        ),
        GoRoute(
          path: gallery,
          name: 'gallery',
          builder: (context, state) => const GalleryPage(),
        ),
        GoRoute(
          path: profile,
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: settings,
          name: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Page not found: ${state.location}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go(home),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _redirect(BuildContext context, GoRouterState state) {
    final authController = Get.find<AuthController>();
    final isLoggedIn = authController.isLoggedIn;
    final isOnLoginPage = state.location == login;
    final isOnSplashPage = state.location == splash;

    // If on splash page, let it handle the navigation
    if (isOnSplashPage) {
      return null;
    }

    // If not logged in and not on login page, redirect to login
    if (!isLoggedIn && !isOnLoginPage) {
      return login;
    }

    // If logged in and on login page, redirect to home
    if (isLoggedIn && isOnLoginPage) {
      return home;
    }

    // No redirect needed
    return null;
  }
}