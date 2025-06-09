import '../entities/family_member.dart';

abstract class FamilyMemberRepository {
  Future<List<FamilyMember>> getAllFamilyMembers();
  Future<List<FamilyMember>> searchFamilyMembers(String query);
  Future<FamilyMember?> getFamilyMemberById(String id);
}