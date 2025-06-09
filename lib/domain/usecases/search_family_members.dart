import '../entities/family_member.dart';
import '../repositories/family_member_repository.dart';

class SearchFamilyMembers {
  final FamilyMemberRepository repository;

  SearchFamilyMembers(this.repository);

  Future<List<FamilyMember>> call(String query) async {
    if (query.trim().isEmpty) {
      return await repository.getAllFamilyMembers();
    }
    return await repository.searchFamilyMembers(query.trim());
  }
}