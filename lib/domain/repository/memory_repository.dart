import 'package:lemon_tree/core/page/page.dart';
import 'package:lemon_tree/domain/model/memory.dart';

abstract class MemoryRepository {
  Future<void> addMemory(String content, String woodName, int themeId);

  Future<void> addMemoryWithTree(String content, int treeId, int themeId);

  Future<Pagination<Memory>> loadMemories(int page,
      {String? woodName, int? themeId});

  Future<Pagination<Memory>> loadMyMemories(int page);

  Future<Memory> loadMemoryWithTree(int treeId);
}
