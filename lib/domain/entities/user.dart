import 'package:equatable/equatable.dart';

enum UserRole { free, premium }

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? photoUrl;
  final DateTime? premiumExpiryDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.photoUrl,
    this.premiumExpiryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        role,
        photoUrl,
        premiumExpiryDate,
        createdAt,
        updatedAt,
      ];

  bool get isPremium => role == UserRole.premium;
  
  bool get isFree => role == UserRole.free;
  
  bool get isPremiumActive {
    if (!isPremium) return false;
    if (premiumExpiryDate == null) return true;
    return DateTime.now().isBefore(premiumExpiryDate!);
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    String? photoUrl,
    DateTime? premiumExpiryDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
      premiumExpiryDate: premiumExpiryDate ?? this.premiumExpiryDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get displayRole {
    switch (role) {
      case UserRole.free:
        return 'Free User';
      case UserRole.premium:
        return 'Premium User';
    }
  }

  String get initials {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names.first[0]}${names.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }
}