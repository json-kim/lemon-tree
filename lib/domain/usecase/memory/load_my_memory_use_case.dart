import 'package:lemon_tree/core/page/page.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/model/memory.dart';
import 'package:lemon_tree/domain/repository/memory_repository.dart';

class LoadMyMemoryUseCase {
  final MemoryRepository _memoryRepository;

  LoadMyMemoryUseCase(this._memoryRepository);

  Future<Result<Pagination<Memory>>> call(int page) async {
    final pageResult = await _memoryRepository.loadMyMemories(page);

    return Result.success(pageResult);
  }
}
