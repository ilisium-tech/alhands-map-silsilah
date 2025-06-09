import 'dart:math';
import '../models/family_member_model.dart';
import '../../core/constants/app_constants.dart';

abstract class FamilyMemberDataSource {
  Future<List<FamilyMemberModel>> getAllFamilyMembers();
  Future<List<FamilyMemberModel>> searchFamilyMembers(String query);
  Future<FamilyMemberModel?> getFamilyMemberById(String id);
}

class MockFamilyMemberDataSource implements FamilyMemberDataSource {
  static final List<FamilyMemberModel> _mockData = _generateMockData();

  @override
  Future<List<FamilyMemberModel>> getAllFamilyMembers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData;
  }

  @override
  Future<List<FamilyMemberModel>> searchFamilyMembers(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (query.isEmpty) return _mockData;
    
    final lowercaseQuery = query.toLowerCase();
    return _mockData.where((member) {
      return member.name.toLowerCase().contains(lowercaseQuery) ||
             member.address.toLowerCase().contains(lowercaseQuery) ||
             (member.occupation?.toLowerCase().contains(lowercaseQuery) ?? false) ||
             member.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  @override
  Future<FamilyMemberModel?> getFamilyMemberById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      return _mockData.firstWhere((member) => member.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<FamilyMemberModel> _generateMockData() {
    final random = Random();
    final now = DateTime.now();
    
    final List<String> firstNames = [
      'Ahmad', 'Siti', 'Budi', 'Rina', 'Joko', 'Dewi', 'Agus', 'Sri', 'Bambang', 'Indira',
      'Hendra', 'Maya', 'Rudi', 'Lestari', 'Eko', 'Ratna', 'Dedi', 'Wulan', 'Fajar', 'Sari',
      'Andi', 'Fitri', 'Yudi', 'Novi', 'Rizki', 'Dian', 'Wahyu', 'Lia', 'Bayu', 'Tari',
      'Irwan', 'Mega', 'Doni', 'Yuni', 'Ari', 'Nita', 'Hadi', 'Rini', 'Joni', 'Sinta',
      'Eko', 'Desi', 'Tono', 'Vina', 'Adi', 'Lina', 'Gani', 'Ika', 'Roni', 'Tina'
    ];
    
    final List<String> lastNames = [
      'Santoso', 'Wijaya', 'Kusuma', 'Pratama', 'Sari', 'Putri', 'Nugroho', 'Handayani',
      'Setiawan', 'Rahayu', 'Permana', 'Lestari', 'Saputra', 'Maharani', 'Gunawan', 'Safitri',
      'Hidayat', 'Anggraini', 'Kurniawan', 'Wulandari', 'Susanto', 'Puspitasari', 'Hartono', 'Indrawati',
      'Suryanto', 'Kartika', 'Wibowo', 'Melati', 'Pranoto', 'Cahyani', 'Sutrisno', 'Pertiwi',
      'Hakim', 'Sartika', 'Budiman', 'Kusumawati', 'Firmansyah', 'Novitasari', 'Sugiarto', 'Purnama'
    ];
    
    final List<String> cities = [
      'Jakarta', 'Surabaya', 'Bandung', 'Bekasi', 'Medan', 'Tangerang', 'Depok', 'Semarang',
      'Palembang', 'Makassar', 'Batam', 'Bogor', 'Pekanbaru', 'Bandar Lampung', 'Malang',
      'Padang', 'Denpasar', 'Samarinda', 'Tasikmalaya', 'Serang', 'Magelang', 'Cilegon',
      'Balikpapan', 'Jambi', 'Surakarta', 'Manado', 'Yogyakarta', 'Cirebon', 'Pontianak',
      'Sukabumi', 'Bengkulu', 'Palu', 'Banjarmasin', 'Kendari', 'Mataram', 'Kupang'
    ];
    
    final List<String> occupations = [
      'Guru', 'Dokter', 'Insinyur', 'Petani', 'Pedagang', 'Pegawai Negeri', 'Wiraswasta',
      'Perawat', 'Polisi', 'Tentara', 'Pilot', 'Sopir', 'Tukang', 'Chef', 'Desainer',
      'Programmer', 'Akuntan', 'Lawyer', 'Arsitek', 'Fotografer', 'Seniman', 'Musisi',
      'Penulis', 'Jurnalis', 'Dosen', 'Peneliti', 'Konsultan', 'Manager', 'Direktur'
    ];
    
    final List<String> relationships = [
      'Ayah', 'Ibu', 'Anak', 'Kakak', 'Adik', 'Paman', 'Bibi', 'Kakek', 'Nenek',
      'Sepupu', 'Keponakan', 'Menantu', 'Mertua', 'Ipar', 'Cucu'
    ];

    final List<String> photoUrls = [
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?w=150&h=150&fit=crop&crop=face',
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&h=150&fit=crop&crop=face',
    ];

    return List.generate(55, (index) {
      final firstName = firstNames[random.nextInt(firstNames.length)];
      final lastName = lastNames[random.nextInt(lastNames.length)];
      final city = cities[random.nextInt(cities.length)];
      final occupation = occupations[random.nextInt(occupations.length)];
      final relationship = relationships[random.nextInt(relationships.length)];
      
      // Generate random coordinates within Java Island bounds
      final lat = AppConstants.javaMinLat + 
          random.nextDouble() * (AppConstants.javaMaxLat - AppConstants.javaMinLat);
      final lng = AppConstants.javaMinLng + 
          random.nextDouble() * (AppConstants.javaMaxLng - AppConstants.javaMinLng);
      
      final birthYear = 1950 + random.nextInt(50);
      final birthMonth = 1 + random.nextInt(12);
      final birthDay = 1 + random.nextInt(28);
      
      return FamilyMemberModel(
        id: 'member_${index + 1}',
        name: '$firstName $lastName',
        photoUrl: photoUrls[random.nextInt(photoUrls.length)],
        address: 'Jl. ${_generateStreetName()} No. ${random.nextInt(100) + 1}, $city, Jawa',
        latitude: lat,
        longitude: lng,
        phoneNumber: '+62${random.nextInt(900000000) + 100000000}',
        email: '${firstName.toLowerCase()}.${lastName.toLowerCase()}@email.com',
        birthDate: DateTime(birthYear, birthMonth, birthDay),
        relationship: relationship,
        occupation: occupation,
        description: _generateDescription(firstName, occupation, city),
        tags: _generateTags(occupation, relationship, city),
        createdAt: now.subtract(Duration(days: random.nextInt(365))),
        updatedAt: now.subtract(Duration(days: random.nextInt(30))),
      );
    });
  }

  static String _generateStreetName() {
    final streetNames = [
      'Merdeka', 'Sudirman', 'Thamrin', 'Gatot Subroto', 'Ahmad Yani', 'Diponegoro',
      'Veteran', 'Pahlawan', 'Pemuda', 'Kartini', 'Dewi Sartika', 'Cut Nyak Dien',
      'Hasanuddin', 'Juanda', 'Malioboro', 'Asia Afrika', 'Braga', 'Dago', 'Cihampelas'
    ];
    return streetNames[Random().nextInt(streetNames.length)];
  }

  static String _generateDescription(String name, String occupation, String city) {
    final descriptions = [
      '$name adalah seorang $occupation yang tinggal di $city. Beliau dikenal sebagai sosok yang ramah dan peduli keluarga.',
      'Sebagai $occupation di $city, $name selalu aktif dalam kegiatan sosial dan kemasyarakatan.',
      '$name bekerja sebagai $occupation dan telah lama menetap di $city bersama keluarga.',
      'Dikenal sebagai $occupation yang berpengalaman, $name adalah sosok yang dihormati di $city.',
      '$name adalah $occupation yang sangat mencintai keluarga dan selalu menjaga silaturahmi.',
    ];
    return descriptions[Random().nextInt(descriptions.length)];
  }

  static List<String> _generateTags(String occupation, String relationship, String city) {
    final baseTags = [occupation, relationship, city];
    final additionalTags = [
      'Keluarga', 'Silaturahmi', 'Tradisi', 'Budaya', 'Jawa', 'Indonesia',
      'Ramah', 'Baik Hati', 'Peduli', 'Aktif', 'Sosial'
    ];
    
    final tags = List<String>.from(baseTags);
    final random = Random();
    
    // Add 2-3 random additional tags
    for (int i = 0; i < 2 + random.nextInt(2); i++) {
      final tag = additionalTags[random.nextInt(additionalTags.length)];
      if (!tags.contains(tag)) {
        tags.add(tag);
      }
    }
    
    return tags;
  }
}