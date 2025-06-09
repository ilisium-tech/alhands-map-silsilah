import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../core/constants/app_constants.dart';
import '../../data/datasources/family_member_datasource.dart';
import '../../data/repositories/family_member_repository_impl.dart';
import '../../domain/entities/family_member.dart';
import '../../domain/usecases/get_all_family_members.dart';
import '../../domain/usecases/search_family_members.dart';
import 'auth_controller.dart';

class FamilyMapController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  
  // Use cases
  late final GetAllFamilyMembers _getAllFamilyMembers;
  late final SearchFamilyMembers _searchFamilyMembers;
  
  // Observable variables
  final RxList<FamilyMember> _allFamilyMembers = <FamilyMember>[].obs;
  final RxList<FamilyMember> _filteredFamilyMembers = <FamilyMember>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _searchQuery = ''.obs;
  final Rx<FamilyMember?> _selectedMember = Rx<FamilyMember?>(null);
  final Rx<LatLng> _mapCenter = const LatLng(AppConstants.defaultLat, AppConstants.defaultLng).obs;
  final RxDouble _mapZoom = AppConstants.defaultZoom.obs;
  final RxBool _isSearching = false.obs;

  // Getters
  List<FamilyMember> get allFamilyMembers => _allFamilyMembers;
  List<FamilyMember> get filteredFamilyMembers => _filteredFamilyMembers;
  bool get isLoading => _isLoading.value;
  String get searchQuery => _searchQuery.value;
  FamilyMember? get selectedMember => _selectedMember.value;
  LatLng get mapCenter => _mapCenter.value;
  double get mapZoom => _mapZoom.value;
  bool get isSearching => _isSearching.value;
  bool get isPremiumUser => _authController.isPremiumUser;
  bool get isFreeUser => _authController.isFreeUser;

  @override
  void onInit() {
    super.onInit();
    _initializeUseCases();
    loadFamilyMembers();
  }

  void _initializeUseCases() {
    final dataSource = MockFamilyMemberDataSource();
    final repository = FamilyMemberRepositoryImpl(dataSource: dataSource);
    _getAllFamilyMembers = GetAllFamilyMembers(repository);
    _searchFamilyMembers = SearchFamilyMembers(repository);
  }

  Future<void> loadFamilyMembers() async {
    try {
      _isLoading.value = true;
      final members = await _getAllFamilyMembers();
      _allFamilyMembers.value = members;
      _filteredFamilyMembers.value = members;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data anggota keluarga: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> searchMembers(String query) async {
    try {
      _isSearching.value = true;
      _searchQuery.value = query;
      
      final members = await _searchFamilyMembers(query);
      _filteredFamilyMembers.value = members;
      
      if (members.isEmpty && query.isNotEmpty) {
        Get.snackbar(
          'Tidak Ditemukan',
          'Tidak ada anggota keluarga yang sesuai dengan pencarian "$query"',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mencari anggota keluarga: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      _isSearching.value = false;
    }
  }

  void clearSearch() {
    _searchQuery.value = '';
    _filteredFamilyMembers.value = _allFamilyMembers;
  }

  void selectMember(FamilyMember member) {
    _selectedMember.value = member;
    centerMapOnMember(member);
  }

  void clearSelection() {
    _selectedMember.value = null;
  }

  void centerMapOnMember(FamilyMember member) {
    _mapCenter.value = LatLng(member.latitude, member.longitude);
    _mapZoom.value = 12.0;
  }

  void updateMapPosition(LatLng center, double zoom) {
    _mapCenter.value = center;
    _mapZoom.value = zoom;
  }

  void showMemberDetails(FamilyMember member) {
    selectMember(member);
    Get.bottomSheet(
      _buildMemberDetailsBottomSheet(member),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildMemberDetailsBottomSheet(FamilyMember member) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Member info
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(member.photoUrl),
                onBackgroundImageError: (_, __) {},
                child: member.photoUrl.isEmpty 
                    ? Text(
                        member.initials,
                        style: Get.theme.textTheme.headlineSmall?.copyWith(
                          color: Get.theme.colorScheme.onPrimary,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: Get.theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (member.relationship != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        member.relationship!,
                        style: Get.theme.textTheme.bodyMedium?.copyWith(
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (member.age != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${member.age} tahun',
                        style: Get.theme.textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Details
          if (member.occupation != null) ...[
            _buildDetailRow(Icons.work, 'Pekerjaan', member.occupation!),
            const SizedBox(height: 12),
          ],
          
          _buildDetailRow(Icons.location_on, 'Alamat', member.address),
          
          if (member.phoneNumber != null) ...[
            const SizedBox(height: 12),
            _buildDetailRow(Icons.phone, 'Telepon', member.phoneNumber!),
          ],
          
          if (member.email != null) ...[
            const SizedBox(height: 12),
            _buildDetailRow(Icons.email, 'Email', member.email!),
          ],
          
          if (member.description != null) ...[
            const SizedBox(height: 20),
            Text(
              'Deskripsi',
              style: Get.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              member.description!,
              style: Get.theme.textTheme.bodyMedium,
            ),
          ],
          
          if (member.tags.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              'Tags',
              style: Get.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: member.tags.map((tag) => Chip(
                label: Text(tag),
                backgroundColor: Get.theme.colorScheme.primaryContainer,
                labelStyle: TextStyle(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  fontSize: 12,
                ),
              )).toList(),
            ),
          ],
          
          const SizedBox(height: 20),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                  label: const Text('Tutup'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                    centerMapOnMember(member);
                  },
                  icon: const Icon(Icons.my_location),
                  label: const Text('Lihat di Peta'),
                ),
              ),
            ],
          ),
          
          // Safe area padding
          SizedBox(height: MediaQuery.of(Get.context!).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Get.theme.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Get.theme.textTheme.bodySmall?.copyWith(
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              Text(
                value,
                style: Get.theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showPremiumFeatureDialog() {
    _authController.showPremiumUpgradeDialog();
  }

  void resetMapView() {
    _mapCenter.value = const LatLng(AppConstants.defaultLat, AppConstants.defaultLng);
    _mapZoom.value = AppConstants.defaultZoom;
    clearSelection();
  }
}