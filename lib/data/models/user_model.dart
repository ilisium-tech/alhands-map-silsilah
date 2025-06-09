import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.photoUrl,
    super.premiumExpiryDate,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: _parseUserRole(json['role'] as String),
      photoUrl: json['photoUrl'] as String?,
      premiumExpiryDate: json['premiumExpiryDate'] != null
          ? DateTime.parse(json['premiumExpiryDate'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': _userRoleToString(role),
      'photoUrl': photoUrl,
      'premiumExpiryDate': premiumExpiryDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      role: entity.role,
      photoUrl: entity.photoUrl,
      premiumExpiryDate: entity.premiumExpiryDate,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      role: role,
      photoUrl: photoUrl,
      premiumExpiryDate: premiumExpiryDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static UserRole _parseUserRole(String roleString) {
    switch (roleString.toLowerCase()) {
      case 'premium':
        return UserRole.premium;
      case 'free':
      default:
        return UserRole.free;
    }
  }

  static String _userRoleToString(UserRole role) {
    switch (role) {
      case UserRole.premium:
        return 'premium';
      case UserRole.free:
        return 'free';
    }
  }
}