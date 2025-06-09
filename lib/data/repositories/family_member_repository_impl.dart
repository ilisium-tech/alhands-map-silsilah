import '../../domain/entities/family_member.dart';
import '../../domain/repositories/family_member_repository.dart';
import '../datasources/family_member_datasource.dart';

class FamilyMemberRepositoryImpl implements FamilyMemberRepository {
  final FamilyMemberDataSource dataSource;

  FamilyMemberRepositoryImpl({required this.dataSource});

  @override
  Future<List<FamilyMember>> getAllFamilyMembers() async {
    try {
      final models = await dataSource.getAllFamilyMembers();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get family members: $e');
    }
  }

  @override
  Future<List<FamilyMember>> searchFamilyMembers(String query) async {
    try {
      final models = await dataSource.searchFamilyMembers(query);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to search family members: $e');
    }
  }

  @override
  Future<FamilyMember?> getFamilyMemberById(String id) async {
    try {
      final model = await dataSource.getFamilyMemberById(id);
      return model?.toEntity();
    } catch (e) {
      throw Exception('Failed to get family member by id: $e');
    }
  }
}