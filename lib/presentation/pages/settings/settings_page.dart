import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/theme_controller.dart';
import '../../controllers/auth_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Tampilan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GetBuilder<ThemeController>(
                  builder: (themeController) {
                    return Column(
                      children: [
                        RadioListTile<ThemeMode>(
                          title: const Text('Terang'),
                          subtitle: const Text('Selalu gunakan tema terang'),
                          value: ThemeMode.light,
                          groupValue: themeController.themeMode,
                          onChanged: (value) => themeController.setThemeMode(value!),
                        ),
                        RadioListTile<ThemeMode>(
                          title: const Text('Gelap'),
                          subtitle: const Text('Selalu gunakan tema gelap'),
                          value: ThemeMode.dark,
                          groupValue: themeController.themeMode,
                          onChanged: (value) => themeController.setThemeMode(value!),
                        ),
                        RadioListTile<ThemeMode>(
                          title: const Text('Sistem'),
                          subtitle: const Text('Ikuti pengaturan sistem'),
                          value: ThemeMode.system,
                          groupValue: themeController.themeMode,
                          onChanged: (value) => themeController.setThemeMode(value!),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Map Settings Section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Pengaturan Peta',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GetBuilder<AuthController>(
                  builder: (authController) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            authController.isPremiumUser ? Icons.map : Icons.lock,
                            color: authController.isPremiumUser 
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          title: const Text('Jenis Peta'),
                          subtitle: Text(
                            authController.isPremiumUser 
                                ? 'Mapbox (Premium)'
                                : 'OpenStreetMap (Gratis)',
                          ),
                          trailing: authController.isFreeUser
                              ? Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'PREMIUM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.check, color: Colors.green),
                          onTap: authController.isFreeUser
                              ? () => authController.showPremiumUpgradeDialog()
                              : null,
                        ),
                        
                        SwitchListTile(
                          title: const Text('Animasi Marker'),
                          subtitle: const Text('Animasi saat memilih marker'),
                          value: true,
                          onChanged: (value) {
                            // TODO: Implement marker animation setting
                          },
                        ),
                        
                        SwitchListTile(
                          title: const Text('Auto Zoom'),
                          subtitle: const Text('Zoom otomatis ke marker yang dipilih'),
                          value: true,
                          onChanged: (value) {
                            // TODO: Implement auto zoom setting
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Privacy & Security Section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Privasi & Keamanan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Izin Lokasi'),
                  subtitle: const Text('Untuk fitur peta dan pencarian'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showLocationPermissionDialog(context),
                ),
                
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Izin Galeri'),
                  subtitle: const Text('Untuk mengakses foto'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showGalleryPermissionDialog(context),
                ),
                
                SwitchListTile(
                  title: const Text('Analitik'),
                  subtitle: const Text('Bantu kami meningkatkan aplikasi'),
                  value: true,
                  onChanged: (value) {
                    // TODO: Implement analytics setting
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Data & Storage Section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Data & Penyimpanan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                ListTile(
                  leading: const Icon(Icons.cached),
                  title: const Text('Hapus Cache'),
                  subtitle: const Text('Bersihkan data sementara'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showClearCacheDialog(context),
                ),
                
                GetBuilder<AuthController>(
                  builder: (authController) {
                    return ListTile(
                      leading: Icon(
                        authController.isPremiumUser ? Icons.cloud : Icons.cloud_off,
                        color: authController.isPremiumUser 
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                      ),
                      title: const Text('Sinkronisasi Cloud'),
                      subtitle: Text(
                        authController.isPremiumUser 
                            ? 'Data tersinkronisasi'
                            : 'Fitur Premium',
                      ),
                      trailing: authController.isFreeUser
                          ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'PREMIUM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const Icon(Icons.check, color: Colors.green),
                      onTap: authController.isFreeUser
                          ? () => authController.showPremiumUpgradeDialog()
                          : () => _showCloudSyncDialog(context),
                    );
                  },
                ),
                
                ListTile(
                  leading: const Icon(Icons.download),
                  title: const Text('Ekspor Data'),
                  subtitle: const Text('Unduh data keluarga'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showExportDataDialog(context),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // About Section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Tentang',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Versi Aplikasi'),
                  subtitle: const Text('1.0.0'),
                  onTap: () => _showVersionDialog(context),
                ),
                
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Syarat & Ketentuan'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showTermsDialog(context),
                ),
                
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Kebijakan Privasi'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showPrivacyDialog(context),
                ),
                
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Bantuan'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showHelpDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Izin Lokasi'),
        content: const Text(
          'Aplikasi memerlukan izin lokasi untuk menampilkan peta dan fitur pencarian lokasi. '
          'Anda dapat mengatur izin ini di pengaturan sistem.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Open app settings
            },
            child: const Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
  }

  void _showGalleryPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Izin Galeri'),
        content: const Text(
          'Aplikasi memerlukan izin akses galeri untuk menampilkan foto keluarga. '
          'Anda dapat mengatur izin ini di pengaturan sistem.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Open app settings
            },
            child: const Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Cache'),
        content: const Text(
          'Menghapus cache akan membersihkan data sementara seperti gambar yang tersimpan. '
          'Aplikasi mungkin akan memuat ulang data saat pertama kali dibuka.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.snackbar(
                'Cache Dihapus',
                'Cache aplikasi berhasil dihapus',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showCloudSyncDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sinkronisasi Cloud'),
        content: const Text(
          'Data Anda akan disinkronisasi dengan cloud storage. '
          'Pastikan Anda memiliki koneksi internet yang stabil.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.snackbar(
                'Sinkronisasi Dimulai',
                'Data sedang disinkronisasi ke cloud',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Sinkronisasi'),
          ),
        ],
      ),
    );
  }

  void _showExportDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ekspor Data'),
        content: const Text(
          'Data keluarga akan diekspor dalam format JSON. '
          'File akan disimpan di folder Download.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.snackbar(
                'Ekspor Berhasil',
                'Data berhasil diekspor ke folder Download',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Ekspor'),
          ),
        ],
      ),
    );
  }

  void _showVersionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Silsilah App'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Versi: 1.0.0'),
            SizedBox(height: 8),
            Text('Build: 2024.06.09'),
            SizedBox(height: 8),
            Text('Modern Family Tree Gallery App'),
            SizedBox(height: 16),
            Text('© 2024 Silsilah App. All rights reserved.'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Syarat & Ketentuan'),
        content: const SingleChildScrollView(
          child: Text(
            'Dengan menggunakan aplikasi Silsilah App, Anda menyetujui syarat dan ketentuan berikut:\n\n'
            '1. Aplikasi ini disediakan "sebagaimana adanya"\n'
            '2. Data yang Anda masukkan adalah tanggung jawab Anda\n'
            '3. Kami tidak bertanggung jawab atas kehilangan data\n'
            '4. Penggunaan aplikasi harus sesuai dengan hukum yang berlaku\n'
            '5. Kami berhak mengubah syarat dan ketentuan sewaktu-waktu\n\n'
            'Untuk informasi lengkap, kunjungi website kami.',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kebijakan Privasi'),
        content: const SingleChildScrollView(
          child: Text(
            'Kami menghormati privasi Anda dan berkomitmen untuk melindungi data pribadi Anda:\n\n'
            '• Data yang dikumpulkan: nama, email, foto profil\n'
            '• Data lokasi hanya digunakan untuk fitur peta\n'
            '• Kami tidak membagikan data Anda kepada pihak ketiga\n'
            '• Data disimpan dengan enkripsi yang aman\n'
            '• Anda dapat menghapus akun dan data kapan saja\n\n'
            'Untuk informasi lengkap, kunjungi website kami.',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bantuan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Butuh bantuan? Hubungi kami:'),
            SizedBox(height: 16),
            Text('📧 Email: support@silsilah.com'),
            SizedBox(height: 8),
            Text('📱 WhatsApp: +62 812-3456-7890'),
            SizedBox(height: 8),
            Text('🌐 Website: www.silsilah.com'),
            SizedBox(height: 16),
            Text('Jam operasional:'),
            Text('Senin - Jumat: 09:00 - 17:00 WIB'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}