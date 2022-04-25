import 'package:lemon_tree/data/data_source/remote/token_api.dart';
import 'package:lemon_tree/domain/repository/memory_repository.dart';

class MemoryRepositoryImpl implements MemoryRepository {
  final TokenApi _tokenApi;

  MemoryRepositoryImpl(this._tokenApi);

  @override
  Future<void> addMemory(String content, String woodName, int themeId) async {
    await _tokenApi.requestAddMemory(content, woodName, themeId);
  }

  @override
  Future<void> addMemoryWithTree(
      String content, int treeId, int themeId) async {
    await _tokenApi.requestAddMemoryWithTree(content, treeId, themeId);
  }
}
