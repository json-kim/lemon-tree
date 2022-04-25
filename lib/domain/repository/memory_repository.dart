abstract class MemoryRepository {
  Future<void> addMemory(String content, String woodName, int themeId);

  Future<void> addMemoryWithTree(String content, int treeId, int themeId);
}
