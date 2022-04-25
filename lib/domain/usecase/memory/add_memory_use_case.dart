import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/repository/memory_repository.dart';

class AddMemoryUseCase {
  final MemoryRepository _memoryRepository;

  AddMemoryUseCase(this._memoryRepository);

  Future<Result<void>> call(
      String content, String woodName, int themeId) async {
    return ErrorApi.handleError(() async {
      final response =
          await _memoryRepository.addMemory(content, woodName, themeId);

      return Result.success(null);
    }, '$runtimeType');
  }
}
