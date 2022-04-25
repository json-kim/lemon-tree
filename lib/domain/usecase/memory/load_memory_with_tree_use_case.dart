import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/model/memory.dart';
import 'package:lemon_tree/domain/repository/memory_repository.dart';

class LoadMemoryWithTreeUseCase {
  final MemoryRepository _memoryRepository;

  LoadMemoryWithTreeUseCase(this._memoryRepository);

  Future<Result<Memory>> call(int treeId) async {
    return ErrorApi.handleError(() async {
      final memory = await _memoryRepository.loadMemoryWithTree(treeId);

      return Result.success(memory);
    }, '$runtimeType');
  }
}
