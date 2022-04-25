import 'package:lemon_tree/core/page/page.dart';
import 'package:lemon_tree/data/data_source/remote/token_api.dart';
import 'package:lemon_tree/domain/model/memory.dart';
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

  @override
  Future<Pagination<Memory>> loadMemories(int page,
      {String? woodName, int? themeId}) async {
    final pageResult;
    if (woodName != null && themeId != null) {
      pageResult =
          await _tokenApi.requestMemoriesWoodTheme(woodName, themeId, page);
    } else if (themeId != null) {
      pageResult = await _tokenApi.requestMemoriesTheme(themeId, page);
    } else if (woodName != null) {
      pageResult = await _tokenApi.requestMemoriesWood(woodName, page);
    } else {
      pageResult = await _tokenApi.requestMemories(page);
    }

    return pageResult;
  }

  @override
  Future<Memory> loadMemoryWithTree(int treeId) async {
    return await _tokenApi.requestMemoryWithTree(treeId);
  }

  @override
  Future<Pagination<Memory>> loadMyMemories(int page) async {
    return await _tokenApi.requestMyMemories(page);
  }
}
