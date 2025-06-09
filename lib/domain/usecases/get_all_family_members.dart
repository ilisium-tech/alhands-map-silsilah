import '../entities/family_member.dart';
import '../repositories/family_member_repository.dart';

class GetAllFamilyMembers {
  final FamilyMemberRepository repository;

  GetAllFamilyMembers(this.repository);

  Future<List<FamilyMember>> call() async {
    return await repository.getAllFamilyMembers();
  }
}