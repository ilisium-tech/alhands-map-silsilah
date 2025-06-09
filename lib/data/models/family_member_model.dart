import '../../domain/entities/family_member.dart';

class FamilyMemberModel extends FamilyMember {
  const FamilyMemberModel({
    required super.id,
    required super.name,
    required super.photoUrl,
    required super.address,
    required super.latitude,
    required super.longitude,
    super.phoneNumber,
    super.email,
    super.birthDate,
    super.relationship,
    super.occupation,
    super.description,
    super.tags,
    required super.createdAt,
    required super.updatedAt,
  });

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    return FamilyMemberModel(
      id: json['id'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      birthDate: json['birthDate'] != null 
          ? DateTime.parse(json['birthDate'] as String)
          : null,
      relationship: json['relationship'] as String?,
      occupation: json['occupation'] as String?,
      description: json['description'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumber': phoneNumber,
      'email': email,
      'birthDate': birthDate?.toIso8601String(),
      'relationship': relationship,
      'occupation': occupation,
      'description': description,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory FamilyMemberModel.fromEntity(FamilyMember entity) {
    return FamilyMemberModel(
      id: entity.id,
      name: entity.name,
      photoUrl: entity.photoUrl,
      address: entity.address,
      latitude: entity.latitude,
      longitude: entity.longitude,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      birthDate: entity.birthDate,
      relationship: entity.relationship,
      occupation: entity.occupation,
      description: entity.description,
      tags: entity.tags,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  FamilyMember toEntity() {
    return FamilyMember(
      id: id,
      name: name,
      photoUrl: photoUrl,
      address: address,
      latitude: latitude,
      longitude: longitude,
      phoneNumber: phoneNumber,
      email: email,
      birthDate: birthDate,
      relationship: relationship,
      occupation: occupation,
      description: description,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}