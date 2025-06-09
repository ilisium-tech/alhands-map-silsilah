import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:silsilah_app/main.dart';
import 'package:silsilah_app/presentation/controllers/auth_controller.dart';
import 'package:silsilah_app/presentation/controllers/theme_controller.dart';

void main() {
  group('Silsilah App Widget Tests', () {
    setUp(() {
      // Initialize GetX controllers for testing
      Get.put(AuthController());
      Get.put(ThemeController());
    });

    tearDown(() {
      // Clean up after each test
      Get.reset();
    });

    testWidgets('App should start with splash screen', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const SilsilahApp());

      // Verify that splash screen is displayed
      expect(find.text('Silsilah App'), findsOneWidget);
      expect(find.text('Modern Family Tree Gallery'), findsOneWidget);
    });

    testWidgets('Should navigate to login after splash', (WidgetTester tester) async {
      await tester.pumpWidget(const SilsilahApp());
      
      // Wait for splash screen animation
      await tester.pumpAndSettle(const Duration(seconds: 4));
      
      // Should navigate to login page
      expect(find.text('Selamat Datang'), findsOneWidget);
      expect(find.text('Masuk sebagai Gratis'), findsOneWidget);
      expect(find.text('Masuk sebagai Premium'), findsOneWidget);
    });

    testWidgets('Free user login should work', (WidgetTester tester) async {
      await tester.pumpWidget(const SilsilahApp());
      await tester.pumpAndSettle(const Duration(seconds: 4));
      
      // Tap free user login button
      await tester.tap(find.text('Masuk sebagai Gratis'));
      await tester.pumpAndSettle();
      
      // Should navigate to home page
      expect(find.text('Silsilah App'), findsOneWidget);
      expect(find.text('Selamat datang,'), findsOneWidget);
    });

    testWidgets('Premium user login should work', (WidgetTester tester) async {
      await tester.pumpWidget(const SilsilahApp());
      await tester.pumpAndSettle(const Duration(seconds: 4));
      
      // Tap premium user login button
      await tester.tap(find.text('Masuk sebagai Premium'));
      await tester.pumpAndSettle();
      
      // Should navigate to home page
      expect(find.text('Silsilah App'), findsOneWidget);
      expect(find.text('Selamat datang,'), findsOneWidget);
    });
  });
}