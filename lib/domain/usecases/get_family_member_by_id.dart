import '../entities/family_member.dart';
import '../repositories/family_member_repository.dart';

class GetFamilyMemberById {
  final FamilyMemberRepository repository;

  GetFamilyMemberById(this.repository);

  Future<FamilyMember?> call(String id) async {
    return await repository.getFamilyMemberById(id);
  }
}