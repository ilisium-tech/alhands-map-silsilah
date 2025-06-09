import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../controllers/family_map_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../components/family_member_marker.dart';
import '../../components/search_bar_widget.dart';

class FamilyMapPage extends StatefulWidget {
  const FamilyMapPage({super.key});

  @override
  State<FamilyMapPage> createState() => _FamilyMapPageState();
}

class _FamilyMapPageState extends State<FamilyMapPage> {
  late final FamilyMapController _controller;
  late final MapController _mapController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = Get.put(FamilyMapController());
    _mapController = MapController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Keluarga'),
        actions: [
          GetBuilder<AuthController>(
            builder: (authController) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: authController.isPremiumUser ? Colors.orange : Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  authController.isPremiumUser ? 'PREMIUM' : 'FREE',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () => _controller.resetMapView(),
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
      body: GetBuilder<FamilyMapController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Memuat data anggota keluarga...'),
                ],
              ),
            );
          }

          return Stack(
            children: [
              // Map
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: controller.mapCenter,
                  zoom: controller.mapZoom,
                  minZoom: 5.0,
                  maxZoom: 18.0,
                  onPositionChanged: (position, hasGesture) {
                    if (hasGesture) {
                      controller.updateMapPosition(
                        position.center!,
                        position.zoom!,
                      );
                    }
                  },
                ),
                children: [
                  // Tile Layer
                  TileLayer(
                    urlTemplate: _getTileUrl(),
                    userAgentPackageName: 'com.silsilah.app',
                    maxZoom: 18,
                  ),
                  
                  // Markers Layer
                  MarkerLayer(
                    markers: controller.filteredFamilyMembers.map((member) {
                      return Marker(
                        point: LatLng(member.latitude, member.longitude),
                        width: 60,
                        height: 60,
                        builder: (context) => FamilyMemberMarker(
                          member: member,
                          isSelected: controller.selectedMember?.id == member.id,
                          onTap: () => controller.showMemberDetails(member),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              
              // Search Bar
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: SearchBarWidget(
                  controller: _searchController,
                  onSearch: (query) => controller.searchMembers(query),
                  onClear: () {
                    _searchController.clear();
                    controller.clearSearch();
                  },
                  isLoading: controller.isSearching,
                ),
              ),
              
              // Map Type Toggle (Premium Feature)
              Positioned(
                top: 80,
                right: 16,
                child: GetBuilder<AuthController>(
                  builder: (authController) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (authController.isFreeUser) {
                                controller.showPremiumFeatureDialog();
                              } else {
                                // Toggle map type for premium users
                                _showMapTypeDialog();
                              }
                            },
                            icon: Icon(
                              authController.isPremiumUser 
                                  ? Icons.layers 
                                  : Icons.lock,
                              color: authController.isPremiumUser 
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          ),
                          if (authController.isFreeUser)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'PRO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Results Counter
              if (controller.searchQuery.isNotEmpty)
                Positioned(
                  bottom: 100,
                  left: 16,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        '${controller.filteredFamilyMembers.length} hasil ditemukan',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      
      // Floating Action Buttons
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Zoom In
          FloatingActionButton(
            mini: true,
            heroTag: 'zoom_in',
            onPressed: () {
              final currentZoom = _mapController.zoom;
              _mapController.move(
                _mapController.center,
                (currentZoom + 1).clamp(5.0, 18.0),
              );
            },
            child: const Icon(Icons.add),
          ),
          
          const SizedBox(height: 8),
          
          // Zoom Out
          FloatingActionButton(
            mini: true,
            heroTag: 'zoom_out',
            onPressed: () {
              final currentZoom = _mapController.zoom;
              _mapController.move(
                _mapController.center,
                (currentZoom - 1).clamp(5.0, 18.0),
              );
            },
            child: const Icon(Icons.remove),
          ),
          
          const SizedBox(height: 16),
          
          // Center Map
          FloatingActionButton(
            heroTag: 'center_map',
            onPressed: () {
              _mapController.move(
                const LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
                AppConstants.defaultZoom,
              );
              _controller.resetMapView();
            },
            child: const Icon(Icons.center_focus_strong),
          ),
        ],
      ),
    );
  }

  String _getTileUrl() {
    final authController = Get.find<AuthController>();
    
    if (authController.isPremiumUser) {
      // For premium users, use Mapbox (requires API key)
      // Note: Replace with actual Mapbox URL template
      return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=${AppConstants.mapboxAccessToken}';
    } else {
      // For free users, use OpenStreetMap
      return AppConstants.openStreetMapUrl;
    }
  }

  void _showMapTypeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Jenis Peta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Streets'),
              onTap: () {
                Navigator.of(context).pop();
                // Switch to streets map
              },
            ),
            ListTile(
              leading: const Icon(Icons.satellite),
              title: const Text('Satellite'),
              onTap: () {
                Navigator.of(context).pop();
                // Switch to satellite map
              },
            ),
            ListTile(
              leading: const Icon(Icons.terrain),
              title: const Text('Terrain'),
              onTap: () {
                Navigator.of(context).pop();
                // Switch to terrain map
              },
            ),
          ],
        ),
      ),
    );
  }
}