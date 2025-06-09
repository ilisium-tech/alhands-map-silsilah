import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/entities/user.dart';

class AuthController extends GetxController {
  final GetStorage _storage = GetStorage();
  
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxBool _isLoading = false.obs;

  User? get currentUser => _currentUser.value;
  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => _currentUser.value != null;
  bool get isPremiumUser => _currentUser.value?.isPremiumActive ?? false;
  bool get isFreeUser => _currentUser.value?.isFree ?? true;

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  void _loadUserFromStorage() {
    final userRole = _storage.read(AppConstants.userRoleKey);
    if (userRole != null) {
      // Create a mock user based on stored role
      _currentUser.value = User(
        id: 'user_1',
        name: 'Demo User',
        email: 'demo@silsilah.com',
        role: userRole == AppConstants.premiumUser ? UserRole.premium : UserRole.free,
        photoUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        premiumExpiryDate: userRole == AppConstants.premiumUser 
            ? DateTime.now().add(const Duration(days: 365))
            : null,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      );
    }
  }

  Future<void> loginAsFreeUser() async {
    _isLoading.value = true;
    
    // Simulate login delay
    await Future.delayed(const Duration(seconds: 1));
    
    final user = User(
      id: 'user_1',
      name: 'Free User',
      email: 'free@silsilah.com',
      role: UserRole.free,
      photoUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _currentUser.value = user;
    await _storage.write(AppConstants.userRoleKey, AppConstants.freeUser);
    
    _isLoading.value = false;
    
    Get.snackbar(
      'Login Berhasil',
      'Selamat datang, ${user.name}!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> loginAsPremiumUser() async {
    _isLoading.value = true;
    
    // Simulate login delay
    await Future.delayed(const Duration(seconds: 1));
    
    final user = User(
      id: 'user_1',
      name: 'Premium User',
      email: 'premium@silsilah.com',
      role: UserRole.premium,
      photoUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      premiumExpiryDate: DateTime.now().add(const Duration(days: 365)),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _currentUser.value = user;
    await _storage.write(AppConstants.userRoleKey, AppConstants.premiumUser);
    
    _isLoading.value = false;
    
    Get.snackbar(
      'Login Berhasil',
      'Selamat datang, ${user.name}! Anda memiliki akses Premium.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> upgradeToPremium() async {
    if (_currentUser.value == null) return;
    
    _isLoading.value = true;
    
    // Simulate upgrade process
    await Future.delayed(const Duration(seconds: 2));
    
    final updatedUser = _currentUser.value!.copyWith(
      role: UserRole.premium,
      premiumExpiryDate: DateTime.now().add(const Duration(days: 365)),
      updatedAt: DateTime.now(),
    );
    
    _currentUser.value = updatedUser;
    await _storage.write(AppConstants.userRoleKey, AppConstants.premiumUser);
    
    _isLoading.value = false;
    
    Get.snackbar(
      'Upgrade Berhasil!',
      'Selamat! Anda sekarang adalah pengguna Premium.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
    );
  }

  Future<void> logout() async {
    _isLoading.value = true;
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    _currentUser.value = null;
    await _storage.remove(AppConstants.userRoleKey);
    
    _isLoading.value = false;
    
    Get.snackbar(
      'Logout Berhasil',
      'Sampai jumpa lagi!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showPremiumUpgradeDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Upgrade ke Premium'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dapatkan akses ke fitur premium:'),
            SizedBox(height: 8),
            Text('• Peta Mapbox dengan kualitas tinggi'),
            Text('• Fitur pencarian lanjutan'),
            Text('• Ekspor data keluarga'),
            Text('• Sinkronisasi cloud'),
            Text('• Dukungan prioritas'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Nanti'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              upgradeToPremium();
            },
            child: const Text('Upgrade Sekarang'),
          ),
        ],
      ),
    );
  }
}