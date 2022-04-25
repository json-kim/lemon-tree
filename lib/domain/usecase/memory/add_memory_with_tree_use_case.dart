import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/repository/memory_repository.dart';
import 'package:lemon_tree/domain/repository/tree_repository.dart';

class AddMemoryWithTreeUseCase {
  final MemoryRepository _memoryRepository;

  AddMemoryWithTreeUseCase(this._memoryRepository);

  Future<Result<void>> call(String content, int treeId, int themeId) async {
    return ErrorApi.handleError(() async {
      await _memoryRepository.addMemoryWithTree(content, treeId, themeId);

      return Result.success(null);
    }, '$runtimeType');
  }
}
